package io.neurolaw.adm.controlador;

import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import io.neurolaw.adm.Util;
import io.neurolaw.adm.beans.cadastros.AcordoBean;
import io.neurolaw.adm.beans.cadastros.ArquivoBean;
import io.neurolaw.adm.controlador.exception.CampoObrigatorioException;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

@Resource
@Path("/arquivo")
@RequestScoped
public class ArquivoControlador extends ConceptualAuthControlador{
	
	
	public ArquivoControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
		/*if (this.isLoggedUser(request)){
			try{
				this.updateUserSession(request, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/autenticar");
			}catch(RequisicaoControllerException e){
				this.getResult().include(this.getMessageType(e), e.getMessage());
				this.setLoggedUser(null, request);
			}
		}*/
	}

	@Get("/detalhar/{id}")
	public void detalharArquivo(MutableRequest request, String id) {
		try{
			this.getLoggedUser(request);
			HttpSession session = request.getSession(false);
			AcordoBean acordo = this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/"+ id, request); 
			session.setAttribute("arquivosDetalhados", acordo);
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();	
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}
	@Post("/upload/{agreementID}")
	public void uploadArquivo(MutableRequest request, String agreementID, UploadedFile arquivo) {
		try{
			System.out.println(agreementID);
			this.getLoggedUser(request);
			this.getResult().include("opAcao", "confirmar-adicao");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	
	@Get("/download/{agreementID}/{attachmentID}")
	public void downloadArquivo(MutableRequest request, String agreementID, String attachmentID) {
		try{
			this.getLoggedUser(request);
			HttpSession session = request.getSession(false);
			ArquivoBean arquivo = this.getWithCredentials(ArquivoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/"+ agreementID +"/attachments/" +attachmentID, request);
			System.out.println(arquivo);
			//session.setAttribute("arquivosDetalhados", arquivo);
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}
	
	@Post("/atualizar/{key}")
	public void formArquivo(MutableRequest request, Long key, UploadedFile novo) {
		try{
			/**
			//File targetFile = new File("/uploads/v2.pdf");
			File targetFile = new File(novo.getFileName());
			OutputStream outStream = new FileOutputStream(targetFile);
			IOUtils.copy(novo.getFile(), outStream);
			**/			
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.updated", this.getResourceMessage("user.entity.name.display"), key, key));
			this.getResult().redirectTo("/arquivo/detalhar/" + key);			
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Get("/remover/{key}")
	public void arquivo(MutableRequest request, Long key) {
		try{
			this.getLoggedUser(request);
			this.deleteWithCredentials(ArquivoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/arquivo/"+key, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.removed", this.getResourceMessage("user.entity.name.display"), key, key));
			this.getResult().redirectTo("/arquivo");			
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Get("/remover/{key}/{versaoKey}")
	public void arquivo(MutableRequest request, Long key, Long versaoKey) {
		try{
			this.getLoggedUser(request);
			//this.deleteWithCredentials(ArquivoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/arquivo/"+key, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.removed", this.getResourceMessage("user.entity.name.display"), key, key));
			this.getResult().redirectTo("/arquivo/detalhar/" + key);			
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Post("/confirmar-adicao")
	public void adicionar(ArquivoBean arquivo, MutableRequest request) {
		try {
			this.validateOperation(arquivo, request, Operation.POST);
			//ArquivoBean usuarioAlterado = this.postWithCredentials(ArquivoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/arquivo/", arquivo, request);
			//this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.created", this.getResourceMessage("user.entity.name.display"), usuarioAlterado.getNome(), usuarioAlterado.getKey()));
			this.getResult().redirectTo("/arquivo");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-adicao");
			this.preserveRequest(arquivo);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/arquivo/adicionar");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}

	@Post("/confirmar-edicao")
	public void alterar(ArquivoBean arquivo, MutableRequest request) {
		try {
			this.validateOperation(arquivo, request, Operation.PUT);
			//this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.updated", this.getResourceMessage("user.entity.name.display"), arquivo.getNome(), arquivo.getKey()));
			this.putWithCredentials(ArquivoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/arquivo/"+arquivo.getKey(), arquivo, request);
			this.getResult().redirectTo("/arquivo");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-edicao");
			this.preserveRequest(arquivo);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/arquivo/editar/"+arquivo.getKey());
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}

	private void validateOperation(ArquivoBean arquivo, MutableRequest request, Operation op){
		if (!op.equals(Operation.DELETE)){
			this.validateFields(arquivo, "nome");
		}
		switch (op) {
		case POST:
		case PUT:
			break;
		case DELETE:
			if (arquivo.getKey()==null){
				throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", this.getResourceMessage("key.field.name.display"), arquivo.getDisplayName()), "msg.act.required.field");
			}    		
			break;
		default:
			throw new CampoObrigatorioException(this.getResourceMessage("msg.error.usuario.unsuported.operation"), "msg.error.usuario.unsuported.operation");
		}

	}

}