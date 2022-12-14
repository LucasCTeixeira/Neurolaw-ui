package io.neurolaw.adm.controlador;

import java.lang.reflect.Field;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.annotate.JsonCreator;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;

import com.cmrevoredo.athena.core.AthenaUtil;
import com.cmrevoredo.athena.core.AthenaUtilException;
import com.cmrevoredo.athena.core.br.validacao.Validador;
import com.cmrevoredo.athena.core.validator.Validator;
import com.cmrevoredo.athena.restclient.client.impl.AthenaRestClientImpl;
import com.cmrevoredo.athena.restclient.entity.AthenaFormField;
import com.cmrevoredo.athena.restclient.exception.AthenaRestClientException;
import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;
import com.google.inject.Inject;
import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.ClientRequest;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.ClientFilter;
import com.sun.jersey.api.json.JSONConfiguration;

import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import io.neurolaw.adm.Util;
import io.neurolaw.adm.beans.ConceptualBean;
import io.neurolaw.adm.beans.MensagemRespostaBean;
import io.neurolaw.adm.controlador.ConceptualAuthControlador.Operation;
import io.neurolaw.adm.controlador.exception.CampoObrigatorioException;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;

public abstract class ConceptualControlador extends AthenaRestClientImpl{
	
	@Inject
	private final Result result;
	@Inject
	private final br.com.caelum.vraptor.Validator validator;
	@Inject
	private final Localization localization;
	@Inject
	private final MutableRequest request;
	
	private static final Logger logger = Logger.getLogger(ConceptualControlador.class.getName());
	public static int STATE_CODE = 1058;
	protected static String HEADER_TOKEN_REQUESTOR_API = "Token-Requestor";
	protected static String HEADER_CACHE_CONTROL_NAME = "Cache-Control";
	
	public ConceptualControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request){
		this.result = result;
		this.validator = validator;
		this.localization = localization;
		this.request = request;
	}
	
	protected <T extends ConceptualBean> PagingResultsBean<T> getPagingResults(int page, int size, String[] uri, String queryString, Class<T> beanType, Operation operation, int cacheMaxAgeMinutes){
		List<T> results = new ArrayList<T>();
		MensagemRespostaBean msg = this.get(MensagemRespostaBean.class, uri[0], cacheMaxAgeMinutes);
		Double rowCount = new Double(msg.getMessage());
		switch (operation) {
		case GET:
			results = this.list(beanType, uri[1], cacheMaxAgeMinutes);
			break;
		default:
			break;
		}		
		return new PagingResultsBean<T>(page, size, rowCount, results, queryString);
	}
	
    public String getResourceMessage(String key, Object... args){
    	String msg = null;
    	try{
    		msg = new String(this.localization.getMessage(key).getBytes("ISO-8859-1"), "UTF-8");
    	}catch(Exception e){
    		msg = this.localization.getMessage(key);
    	}
    	return MessageFormat.format(msg, args);
    }
	
	protected Localization getLocalization() {
		return localization;
	}
	
	protected Result getResult() {
		return result;
	}
	
	public MutableRequest getRequest() {
		return request;
	}

	public br.com.caelum.vraptor.Validator getValidator() {
		return validator;
	}

	protected void preserveRequest(ConceptualBean bean) throws AthenaRestClientException{
		this.preserveRequest(bean, bean.getJsonType()+"Temp");
	}

	protected void preserveRequest(ConceptualBean bean, String name) throws AthenaRestClientException{
		this.getResult().include(name, bean);
	}
	
	protected void validateFields(ConceptualBean bean) throws RequisicaoControllerException, CampoObrigatorioException{
		List<Field> fieldsToValidate = new ArrayList<Field>();
    	try {
    		fieldsToValidate = AthenaUtil.getAtributosEntidade(bean);
		} catch (AthenaUtilException e) {
			throw new RequisicaoControllerException(500, e.getMessage(), e.getMessage());
		}
    	validate(bean, fieldsToValidate);
	}
	
	protected void validateFields(ConceptualBean bean, String... fields) throws RequisicaoControllerException, CampoObrigatorioException{
    	List<Field> fieldsToValidate = new ArrayList<Field>();
    	try {
    		List<Field> allFields = AthenaUtil.getAtributosEntidade(bean);
			for (String f : fields) {
				for (Field field : allFields) {
					if (field.getName().equals(f)){
						fieldsToValidate.add(field);
						break;
					}
				}
			}
		} catch (AthenaUtilException e) {
			throw new RequisicaoControllerException(500, e.getMessage(), e.getMessage());
		}
    	validate(bean, fieldsToValidate);		
	}
	
	@JsonCreator
    private void validate(ConceptualBean bean, List<Field> fields) throws RequisicaoControllerException, CampoObrigatorioException{
    	for (Field field : fields) {
			if (field.isAnnotationPresent(AthenaFormField.class)){
				AthenaFormField ann = field.getAnnotation(AthenaFormField.class);
				Object value = null;
				try {
					value = field.get(bean);
				} catch (IllegalArgumentException | IllegalAccessException e) {
					throw new RequisicaoControllerException(500, e.getMessage(), e.getMessage());
				}
				if (ann.isRequired()){
					if (value==null || value.toString().equals("null") || value.toString().isEmpty()){
						throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", field.getName(), bean.getDisplayName()), "msg.act.required.field");
					}
				}
				
				if (value!=null){
					switch (ann.type()) {
					case CEP:
						if (!Validador.isCEPValido(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case CNPJ:
						if (!Validador.isCNPJValido(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case CPF:
						if (!Validador.isCPFValido(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case CURRENCY:
						if (!Validator.isValidCurrency(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case DATE:
						break;
					case DATETIME:
						break;
					case EMAIL:
						if (!Validator.isValidEmail(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case INTEGER:
						if (!Validator.isValidNumeric(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case ALPHA:
						if (!Validator.isValidAlpha(value.toString(), true)){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case ALPHA_WITHOUT_SPECIAL_CHARS:
						if (!Validator.isValidAlpha(value.toString(), false)){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					case PHONE:
						break;
					case RG:
						if (Validator.isNullOrEmptyString(value.toString())){
							throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
						}
						break;
					default:
						if (value instanceof Collection<?>){
							if (((Collection<?>)value).isEmpty()){
								throw new CampoObrigatorioException(this.getResourceMessage("msg.act.invalid.field", field.getName(), bean.getDisplayName()), "msg.act.invalid.field");
							}							
						}						
						break;
					}
				}				
			}
		}    	
    }

    private <T extends ConceptualBean> Object sendToServer(Class<T> beanType, String uri, String method, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, boolean isUniqueResult, final int maxAgeMinutes) throws RequisicaoControllerException{
    	ClientResponse clientResponse = null;
    	if (filters==null){
    		filters =  new ArrayList<ClientFilter>();
    	}
    	filters.add(new ClientFilter() {
			@Override
			public ClientResponse handle(ClientRequest request)
					throws ClientHandlerException {
				request.getHeaders().putSingle(HEADER_TOKEN_REQUESTOR_API, Util.getConfigProperty("api.portal.token.requestor"));
				/*
				if (maxAgeMinutes> 0){
					request.getHeaders().putSingle(HEADER_CACHE_CONTROL_NAME, "no-transform, max-age=" + maxAgeMinutes + "m");
				}
				*/
		        return getNext().handle(request);				
			}
		});
    	
		switch (method) {
		case "POST":
		case "PUT":
		case "DELETE":
			try{
				clientResponse = this.getClientResponse(uri, method, payload, config, filters);
			}catch (Exception e) {
				logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + e.getMessage());
				//e.printStackTrace();
			}
			break;
		default:
			config = new DefaultClientConfig();
			config.getClasses().add(JacksonJsonProvider.class);
			config.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
			try{
				clientResponse = this.getClientResponse(uri, method, null, config, filters);
			}catch (Exception e) {
				logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + e.getMessage());
				//e.printStackTrace();
			}
			break;		
		}
		MensagemRespostaBean msg = null;
		
		int code = 404;
		try {
			code = clientResponse.getStatus();
		}catch(Exception e) {
		}
		
		switch (code) {
			case 200:
				if (isUniqueResult){
					return clientResponse.getEntity(beanType);
				}else{
					ObjectMapper objectMapper = new ObjectMapper();
					objectMapper.configure(
						    DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
					String output = clientResponse.getEntity(String.class);
					if (output.replace("\"", "").contains("message:") & output.replace("\"", "").contains("statusCode:")){
						try{
							msg = objectMapper.readValue(output, MensagemRespostaBean.class);
						}catch (Exception e) {
							logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + output);
							msg = new MensagemRespostaBean(500, this.getResourceMessage("msg.unexpected.error", ""));
						}
						throw new RequisicaoControllerException(msg.getStatusCode(), this.getResourceMessage(msg.getMessage()), msg.getMessage());
					}else{
						List<T> list = new ArrayList<T>();
						try{
							T bean = beanType.newInstance();
							JsonNode result = objectMapper.readTree(output);
							if (!result.isArray()){
								bean = objectMapper.readValue(result, beanType);
								list.add(bean);
							}else{
								for (JsonNode jsonNode : result) {
								    bean = objectMapper.readValue(jsonNode, beanType);
								    list.add(bean);
								}
							}	
							return list;
						}catch(Exception e){
							logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + e.getMessage());
							//e.printStackTrace();
							throw new RequisicaoControllerException(500, this.getResourceMessage("msg.unexpected.error", ""), "msg.unexpected.error");
						}
					}
				}
			case 401:
				try{
					msg = clientResponse.getEntity(MensagemRespostaBean.class);				
				}catch (Exception e) {
					throw new RequisicaoControllerException(401, this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"), "neurolaw.api.msg.error.usuario.unauthorized");
				}
				throw new RequisicaoControllerException(401, this.getResourceMessage(msg.getMessage()), msg.getMessage());			
			case 404:
				logger.log(Level.SEVERE, "HTTP 404: " + uri);
				throw new RequisicaoControllerException(404, this.getResourceMessage("neurolaw.api.msg.error.service.not.avaliable"+uri), "neurolaw.api.msg.error.service.not.avaliable"+uri);
			case 415:
				throw new RequisicaoControllerException(415, this.getResourceMessage("neurolaw.adm.msg.error.unsupported.media.type"), "neurolaw.adm.msg.error.unsupported.media.type");			
			default:
				String strError = clientResponse.getEntity(String.class);
				msg = null;
				try{
					ObjectMapper objectMapper = new ObjectMapper();					
					objectMapper.configure(
						    DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
					msg = objectMapper.readValue(strError, MensagemRespostaBean.class);
				}catch (Exception e) {
					logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + strError);
					msg = new MensagemRespostaBean(500, this.getResourceMessage("msg.unexpected.error", ""));
				}
				throw new RequisicaoControllerException(msg.getStatusCode(), this.getResourceMessage(msg.getMessage()), msg.getMessage());				
			}			
	}

	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T get(Class<T> beanType, String uri) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "GET", null, null, null, true, 0);
	}

	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T get(Class<T> beanType, String uri, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "GET", null, null, null, true, maxAgeMinutes);
	}
	
	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T get(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "GET", null, config, filters, true, 0);
	}

	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T get(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "GET", null, config, filters, true, maxAgeMinutes);
	}
	
	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> list(Class<T> beanType, String uri) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServer(beanType, uri, "GET", null, null, null, false, 0);
	}

	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> list(Class<T> beanType, String uri, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServer(beanType, uri, "GET", null, null, null, false, maxAgeMinutes);
	}
	
    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> list(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServer(beanType, uri, "GET", null, config, filters, false, 0);
	}
    
    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> list(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServer(beanType, uri, "GET", null, config, filters, false, maxAgeMinutes);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T post(Class<T> beanType, String uri, ConceptualBean payload) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "POST", payload, null, null, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T post(Class<T> beanType, String uri, ConceptualBean payload, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "POST", payload, null, null, true, 0);
	}
    
    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T post(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "POST", payload, config, filters, true, maxAgeMinutes);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T put(Class<T> beanType, String uri, ConceptualBean payload) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "PUT", payload, null, null, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T put(Class<T> beanType, String uri, ConceptualBean payload, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "PUT", payload, null, null, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T put(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "PUT", payload, null, null, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T put(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "PUT", payload, null, null, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", null, null, null, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", null, null, null, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", payload, null, null, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", payload, null, null, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", payload, config, filters, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServer(beanType, uri, "DELETE", payload, config, filters, true, maxAgeMinutes);
	}
    
    protected String getMessageType(RequisicaoControllerException e){
    	String type = "msg_error";
    	if (e.getChave()!=null){
    		if (e.getChave().contains("neurolaw.api.msg.warning") || e.getChave().contains("neurolaw.adm.msg.warning")){
    			type = "msg_alert";
    		}
    		if (e.getChave().contains("neurolaw.api.msg.info") || e.getChave().contains("neurolaw.adm.msg.info")){
    			type = "msg_info";
    		}
    		if (e.getChave().contains("neurolaw.api.msg.success") || e.getChave().contains("neurolaw.adm.msg.success")){
    			type = "msg_success";
    		}
    	}
    	return type;
    }
}
