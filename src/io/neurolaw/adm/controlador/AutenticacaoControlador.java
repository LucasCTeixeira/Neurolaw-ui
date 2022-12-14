package io.neurolaw.adm.controlador;

import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.ioc.RequestScoped;
import io.neurolaw.adm.Util;
import io.neurolaw.adm.beans.cadastros.EmpresaBean;
import io.neurolaw.adm.beans.cadastros.UsuarioBean;
import io.neurolaw.adm.controlador.exception.CampoObrigatorioException;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

@Resource
@Path("/acesso")
@RequestScoped
public class AutenticacaoControlador extends ConceptualAuthControlador{
	
	
	private EmpresaBean empresa = new EmpresaBean("Empresa teste");
	private UsuarioBean usuarioA = new UsuarioBean("cmrs", "neuro", empresa);
	private UsuarioBean usuarioB = new UsuarioBean("lct", "neuro", empresa);
	private UsuarioBean usuarioC = new UsuarioBean("bjtf", "neuro", empresa);


	public AutenticacaoControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
		if (this.isLoggedUser(request)){
			try{
				this.updateUserSession(request, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/autenticar");
			}catch(RequisicaoControllerException e){
				this.getResult().include(this.getMessageType(e), e.getMessage());
				this.setLoggedUser(null, request);
			}
		}
	}

	@Get("/deslogar")
	public void deslogar(MutableRequest request) {
		try {
			if (this.getLoggedUser(request)!=null){				
				this.setLoggedUser(null, request);
				this.getResult().include("msg_success", this.getResourceMessage("msg.act.usuario.logout.success"));
			}
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();		
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()!=null?e.getMessage():""));
		}
		this.getResult().redirectTo("/");		
	}	

	
	@Post("/autenticar")
	public void autenticar(UsuarioBean usuario, MutableRequest request) {
		try {
			validateFields(usuario, "login", "senha");
			HttpSession session = request.getSession(false);
			if (session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION)==null){
				UsuarioBean usuarioAutenticado = null;
				if ((usuario.getLogin().equals(this.usuarioA.getLogin())) && usuario.getPassword().equals(this.usuarioA.getPassword())) {
					usuarioAutenticado = this.usuarioA;
				}else if((usuario.getLogin().equals(this.usuarioB.getLogin())) && usuario.getPassword().equals(this.usuarioB.getPassword())) {
					usuarioAutenticado = this.usuarioB;
				} else if((usuario.getLogin().equals(this.usuarioC.getLogin())) && usuario.getPassword().equals(this.usuarioC.getPassword())) {
					usuarioAutenticado = this.usuarioC;
				} else {
					new Exception(); //Verificar isso
				}
				this.setLoggedUser(usuarioAutenticado, request);
				this.getResult().include("msg_success", this.getResourceMessage("neurolaw.api.msg.success.usuario.was.logged"));
				this.getResult().redirectTo("/restrito");
			}
		} catch (CampoObrigatorioException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()!=null?e.getMessage():""));
			this.getResult().redirectTo("/");
		}		
	}
	
	
	/*@Post("/autenticar")
	public void autenticar(UsuarioBean usuario, MutableRequest request) {
		try {
			validateFields(usuario, "login", "senha");
			HttpSession session = request.getSession(false);
			if (session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION)==null){
				UsuarioBean usuarioAutenticado = this.post(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/autenticar", usuario);
				this.setLoggedUser(usuarioAutenticado, request);
				this.getResult().include("msg_success", this.getResourceMessage("neurolaw.api.msg.success.usuario.was.logged"));
				this.getResult().redirectTo("/restrito");
			}
		} catch (CampoObrigatorioException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()!=null?e.getMessage():""));
			this.getResult().redirectTo("/");
		}		
	}*/

}