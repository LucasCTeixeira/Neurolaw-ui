package io.neurolaw.adm.controlador;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;

import com.sun.jersey.api.client.ClientResponse;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.http.MutableResponse;
import br.com.caelum.vraptor.interceptor.download.FileDownload;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import io.neurolaw.adm.Util;
import io.neurolaw.adm.beans.cadastros.AcordoBean;
import io.neurolaw.adm.beans.cadastros.ArquivoBean;
import io.neurolaw.adm.beans.cadastros.DataBean;
import io.neurolaw.adm.beans.cadastros.EmpresaBean;
import io.neurolaw.adm.beans.cadastros.UsuarioBean;
import io.neurolaw.adm.controlador.exception.CampoObrigatorioException;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

@Resource
@Path("/acordo")
@RequestScoped
public class AcordoControlador extends ConceptualAuthControlador{

	public static UsuarioBean USUARIO_LOGADO = new UsuarioBean();

	static {		

		USUARIO_LOGADO.setKey(1L);
		USUARIO_LOGADO.setLogin("cmrs");
		USUARIO_LOGADO.setPassword("neuro");

		EmpresaBean empresaA = new EmpresaBean();
		empresaA.setKey(1L);
		empresaA.setNome("Empresa teste");

		USUARIO_LOGADO.setEmpresa(empresaA);
	}

	public AcordoControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
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

	@Get("/")
	public void acordo(MutableRequest request) {
		try{
			this.getLoggedUser(request);
			DataBean resultado = this.getWithCredentials(DataBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement?page=1&pageSize=10", request);
			this.getResult().include("registros", resultado.getData());
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

	@Get("/editar/{id}")
	public void formAcordo(MutableRequest request, String id) {
		try{
			this.getLoggedUser(request);
			AcordoBean acordo = this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + id, request);
			//ErroBean erro = this.getWithCredentials(DataBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + id, request);
			List<String> participantes = new ArrayList<String>();
			participantes.add("O=PartyA, L=London, C=GB");
			participantes.add("O=PartyB, L=New York, C=US");
			participantes.add("O=PartyC, L=New York, C=US");
			participantes.add("O=JPMorgan, L=New York, C=US");
			participantes.add("O=UPE, L=Recife, C=BR");
			participantes.add("O=Google, L=California, C=US");
			participantes.add("O=Neurolaw Party, L=Recife, C=BR");
			this.getResult().include("participantes", participantes);
			this.preserveRequest(acordo);
			this.getResult().include("opAcao", "confirmar-edicao");
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

	@Get("/arquivo/detalhar/{agreementId}")
	public void detalharArquivo(MutableRequest request, String agreementId) {
		try{
			this.getLoggedUser(request);
			HttpSession session = request.getSession(false);
			AcordoBean acordo = this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + agreementId, request);
			session.setAttribute("acordo", acordo);
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

	@Post("/arquivo/upload/{agreementId}")
	public void detalharArquivo(MutableRequest request, String agreementId, UploadedFile arquivo) {
		try{
			this.getLoggedUser(request);
			if(arquivo == null) {
				System.out.println("Nulo");
			}else {
				System.out.println("O array de bytes:" + arquivo.getFile());
			}
			// faz aqui a chamada para o upload no corda, passando o array de bytes
			AcordoBean acordo = this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + agreementId, request);
			HttpSession session = request.getSession(false);
			session.setAttribute("acordo", acordo);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.updated", this.getResourceMessage("user.entity.name.display"), agreementId, agreementId));
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

	@Get("/arquivo/download/{agreementId}/{attachmentId}")
	public FileDownload detalharArquivo(MutableRequest request, MutableResponse response, String agreementId, String attachmentId) {
		this.getLoggedUser(request);
		AcordoBean acordo = this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + agreementId, request);
		String tipo = "application/download"; // tenta pega o tipo pelo corda
		String filename = "singleAttachment.txt"; // tenta pegar o nome pelo corda
		for (ArquivoBean arquivo : acordo.getAttachments()) {
			if (arquivo.getId().equals(attachmentId)) {
				filename = arquivo.getFilename();
			}
		}
		ClientResponse cr = this.getClientResponse(Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + agreementId + "/attachments/" + attachmentId, "GET");
		File arquivo = new File(filename);
		try(OutputStream outputStream = new FileOutputStream(arquivo)){
			IOUtils.copy(cr.getEntityInputStream(), outputStream);
		} catch (FileNotFoundException e) {
		} catch (IOException e) {
		}
		//response.addHeader("Content-Disposition", "attachment; filename=" + filename + ".txt");
		return new FileDownload(arquivo, tipo, filename);
	}

	@Get("/detalhar/{id}")
	public void detalharAcordo(MutableRequest request, String id) {
		try{
			this.getLoggedUser(request);
			HttpSession session = request.getSession(false);
			AcordoBean acordo =this.getWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/"+ id, request); 
			session.setAttribute("acordo", acordo);
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();	
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.acordo(request);
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Get("/historico/{id}")
	public void historicoAcordo(MutableRequest request, String id) {
		try{
			this.getLoggedUser(request);
			HttpSession session = request.getSession(false);
			DataBean data = this.getWithCredentials(DataBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/"+ id + "/history", request);
			session.setAttribute("id", id);
			session.setAttribute("registros", data.getData());
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();	
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.acordo(request);
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Get("/adicionar")
	public void formAcordo(MutableRequest request) {
		try{
			this.getLoggedUser(request);
			List<String> participantes = new ArrayList<String>();
			participantes.add("O=PartyA, L=London, C=GB");
			participantes.add("O=PartyB, L=New York, C=US");
			participantes.add("O=PartyC, L=New York, C=US");
			participantes.add("O=JPMorgan, L=New York, C=US");
			participantes.add("O=UPE, L=Recife, C=BR");
			participantes.add("O=Google, L=California, C=US");
			participantes.add("O=Neurolaw Party, L=Recife, C=BR");
			this.getResult().include("participantes", participantes);			
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


	@Get("/remover/{agreementId}")
	public void acordo(MutableRequest request, String agreementId) {
		try{
			this.getLoggedUser(request);
			this.deleteWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/"+agreementId, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.removed", this.getResourceMessage("user.entity.name.display"), agreementId, agreementId));
			this.getResult().redirectTo("/acordo");			
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.acordo(request);
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
	}

	@Post("/confirmar-adicao")
	public void adicionar(AcordoBean acordo, MutableRequest request) {
		try {
			this.validateOperation(acordo, request, Operation.POST);
			//AcordoBean resultado = this.postWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/", acordo, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.created", this.getResourceMessage("user.entity.name.display"), acordo.getAgreementName(), acordo.getAgreementName()));
			this.getResult().redirectTo("/acordo");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-adicao");
			this.preserveRequest(acordo);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/acordo/adicionar");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}

	@Post("/confirmar-edicao")
	public void formAcordo(AcordoBean acordo, MutableRequest request) {
		try {
			acordo.setAgreementStatus("OPEN");
			this.validateOperation(acordo, request, Operation.POST);
			try {
				this.putWithCredentials(AcordoBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/agreement/" + acordo.getAgreementId(), acordo, request);
			}catch (Exception e) {
				e.printStackTrace();
			}
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.updated", this.getResourceMessage("user.entity.name.display"), acordo.getAgreementName(), acordo.getAgreementId()));
			this.getResult().redirectTo("/acordo");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-edicao");
			this.preserveRequest(acordo);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/acordo/editar/"+acordo.getAgreementId());
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}

	private void validateOperation(AcordoBean acordo, MutableRequest request, Operation op){
		if (!op.equals(Operation.DELETE)){
			this.validateFields(acordo, "nome");
		}
		switch (op) {
		case POST:
		case PUT:
			break;
		case DELETE:
			break;
		default:
			throw new CampoObrigatorioException(this.getResourceMessage("msg.error.usuario.unsuported.operation"), "msg.error.usuario.unsuported.operation");
		}

	}

}