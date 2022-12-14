package io.neurolaw.adm.controlador;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.annotate.JsonCreator;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;

import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.ClientRequest;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.filter.ClientFilter;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import io.neurolaw.adm.Util;
import io.neurolaw.adm.beans.ConceptualBean;
import io.neurolaw.adm.beans.MensagemRespostaBean;
import io.neurolaw.adm.beans.cadastros.UsuarioBean;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

public class ConceptualAuthControlador extends ConceptualControlador{
	
	protected enum Operation {GET, POST, PUT, DELETE};
	private static final Logger logger = Logger.getLogger(ConceptualControlador.class.getName());
	
    protected void updateUserSession(MutableRequest request, String userLogonURI){
		this.setLoggedUser(this.postWithCredentials(UsuarioBean.class, userLogonURI, this.getLoggedUser(request), request), request);
    }
	
	protected boolean isLoggedUser(MutableRequest request){
		HttpSession session = request.getSession(false);
		return session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION)!=null;
	}
	
	public ConceptualAuthControlador(Result result, Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
	}

	protected <T extends ConceptualBean> PagingResultsBean<T> getPagingResultsWithCredentials(int page, int size, String[] uri, String queryString, Class<T> beanType, Operation operation, MutableRequest request, int cacheMaxAgeMinutes){
		List<T> results = new ArrayList<T>();
		MensagemRespostaBean msg = this.getWithCredentials(MensagemRespostaBean.class, uri[0], request, cacheMaxAgeMinutes);
		Double rowCount = new Double(msg.getMessage());
		switch (operation) {
		case GET:
			results = this.listWithCredentials(beanType, uri[1], request, cacheMaxAgeMinutes);
			break;
		default:
			break;
		}
		return new PagingResultsBean<T>(page, size, rowCount, results, queryString);
	}
	
	public static String NOTIFY_USER_STATUS = "msg_alert";
	public static String NOTIFY_USER_STATUS_TIME = "msg_alert_time";
	public static String LOGGED_USER_ATTRIBUTE_SESSION = "userLogged";
	
	public static String ATRIBUTO_OCORRENCIA = "ocorrencia";
	public static String ATRIBUTO_CACHE_UFS = "ufLista";	
	public static String ATRIBUTO_CACHE_MUNICIPIOS = "municipioLista";

	protected ClientResponse getClientResponseWithCredentials(String resource, String action, MutableRequest request) throws RequisicaoControllerException, UserSessionEndedException{
		return this.getClientResponseWithCredentials(resource, action, null, null, null, request);
	}

	protected ClientResponse getClientResponseWithCredentials(String resource, String action, Object payload, MutableRequest request) throws RequisicaoControllerException, UserSessionEndedException{
		return this.getClientResponseWithCredentials(resource, action, payload, null, null, request);
	}

	protected ClientResponse getClientResponseWithCredentials(String resource, String action, Object payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException, UserSessionEndedException{
		UsuarioBean usuario = this.getLoggedUser(request);
		if (filters==null){
			filters = new ArrayList<ClientFilter>();
		}
		filters.add(new HTTPBasicAuthFilter(usuario.getLogin(), usuario.getPassword ()));
		return getClientResponse(resource, action, payload, config, filters);
	}
	
	protected UsuarioBean getLoggedUser(MutableRequest request) throws UserSessionEndedException{
		HttpSession session = request.getSession(false);
		if (session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION)!=null){
			return (UsuarioBean)session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION);
		}else{
			throw new UserSessionEndedException(new MensagemRespostaBean(401, this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthenticated")), "neurolaw.api.msg.error.usuario.unauthenticated");
		}
	}

	protected void setLoggedUser(UsuarioBean usuario, MutableRequest request) throws UserSessionEndedException{
		HttpSession session = request.getSession(false);
		session.setAttribute(LOGGED_USER_ATTRIBUTE_SESSION, usuario);
		if (usuario!=null){
			request.removeAttribute(NOTIFY_USER_STATUS);
			request.removeAttribute(NOTIFY_USER_STATUS_TIME);
		}
	}
	
	@JsonCreator
    private <T extends ConceptualBean> Object sendToServerWithCredentials(Class<T> beanType, String uri, String method, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request, boolean isUniqueResult, final int maxAgeMinutes) throws RequisicaoControllerException{
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
				clientResponse = this.getClientResponseWithCredentials(uri, method, payload, config, filters, request);
			}catch (Exception e) {
				logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + e.getMessage());
				//e.printStackTrace();
			}				
			break;
		default:
			try{
				clientResponse = this.getClientResponseWithCredentials(uri, method, null, config, filters, request);
			}catch (Exception e) {
				logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + e.getMessage());
				//e.printStackTrace();
			}				
			break;		
		}
		MensagemRespostaBean msg = null;
		switch (clientResponse.getStatus()) {
		case 200:
			if (isUniqueResult){
				return clientResponse.getEntity(beanType);
			}else{
				String output = clientResponse.getEntity(String.class);
				List<T> list = new ArrayList<T>();
				try{
					T bean = beanType.newInstance();
					ObjectMapper objectMapper = new ObjectMapper();
					objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
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
		case 401:
			try{
				msg = clientResponse.getEntity(MensagemRespostaBean.class);				
			}catch (Exception e) {
				throw new RequisicaoControllerException(401, this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"), "neurolaw.api.msg.error.usuario.unauthorized");
			}
			throw new RequisicaoControllerException(401, this.getResourceMessage(msg.getMessage()), msg.getMessage());			
		case 404:
			logger.log(Level.SEVERE, "HTTP 404: " + uri);
			throw new RequisicaoControllerException(404, this.getResourceMessage("neurolaw.api.msg.error.service.not.avaliable: "+uri), "neurolaw.api.msg.error.service.not.avaliable"+uri);
		case 405:
			throw new RequisicaoControllerException(405, this.getResourceMessage("msg.act.method.not.allowed"), "msg.act.method.not.allowed");
		default:
			String strError = clientResponse.getEntity(String.class);
			msg = null;
			try{
				ObjectMapper objectMapper = new ObjectMapper();
				msg = objectMapper.readValue(strError, MensagemRespostaBean.class);
			}catch (Exception e) {
				logger.log(Level.SEVERE, "ERROR DESCRIPTION: " + strError);
				msg = new MensagemRespostaBean(500, this.getResourceMessage("msg.unexpected.error", ""));
			}
			throw new RequisicaoControllerException(msg.getStatusCode(), this.getResourceMessage(msg.getMessage()), msg.getMessage());				
		}			
	}

    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T getWithCredentials(Class<T> beanType, String uri, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "GET", null, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> T getWithCredentials(Class<T> beanType, String uri, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "GET", null, null, null, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T getWithCredentials(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "GET", null, config, filters, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T getWithCredentials(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "GET", null, config, filters, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T postWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "POST", payload, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T postWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "POST", payload, null, null, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T postWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "POST", payload, config, filters, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T postWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "POST", payload, config, filters, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T putWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "PUT", payload, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T putWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "PUT", payload, null, null, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T putWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "PUT", payload, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T putWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "PUT", payload, null, null, request, true, maxAgeMinutes);
	}
    
    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T deleteWithCredentials(Class<T> beanType, String uri, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", null, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T deleteWithCredentials(Class<T> beanType, String uri, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", null, null, null, request, true, maxAgeMinutes);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", payload, null, null, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T delete(Class<T> beanType, String uri, ConceptualBean payload, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", payload, null, null, request, true, maxAgeMinutes);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T deleteWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", payload, config, filters, request, true, 0);
	}

    @SuppressWarnings("unchecked")
    protected <T extends ConceptualBean> T deleteWithCredentials(Class<T> beanType, String uri, ConceptualBean payload, ClientConfig config, List<ClientFilter> filters, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (T)this.sendToServerWithCredentials(beanType, uri, "DELETE", payload, config, filters, request, true, maxAgeMinutes);
	}
    
	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> listWithCredentials(Class<T> beanType, String uri, MutableRequest request) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServerWithCredentials(beanType, uri, "GET", null, null, null, request, false, 0);
	}

	@SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> listWithCredentials(Class<T> beanType, String uri, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServerWithCredentials(beanType, uri, "GET", null, null, null, request, false, maxAgeMinutes);
	}
	
    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> listWithCredentials(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, MutableRequest request) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServerWithCredentials(beanType, uri, "GET", null, config, filters, request, false, 0);
	}

    @SuppressWarnings("unchecked")
	protected <T extends ConceptualBean> List<T> listWithCredentials(Class<T> beanType, String uri, ClientConfig config, List<ClientFilter> filters, MutableRequest request, final int maxAgeMinutes) throws RequisicaoControllerException{
    	return (List<T>)this.sendToServerWithCredentials(beanType, uri, "GET", null, config, filters, request, false, maxAgeMinutes);
	}
    
}
