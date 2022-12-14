package io.neurolaw.adm.controlador;

import java.util.List;

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
import io.neurolaw.adm.beans.cadastros.UsuarioBean;
import io.neurolaw.adm.controlador.exception.CampoObrigatorioException;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

@Resource
@Path("/usuario")
@RequestScoped
public class UsuarioControlador extends ConceptualAuthControlador{

	public UsuarioControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
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

	@Get("/")
    public void usuario(MutableRequest request) {
		try{
			/*
			UsuarioBean usuario = this.getLoggedUser(request);
			if (!usuario.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/			
			this.getLoggedUser(request);
			List<UsuarioBean> usuarios = this.listWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/", request);
			this.getResult().include("registros", usuarios);
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
	
	@Get("/detalhar/{key}")
    public void detalharUsuario(MutableRequest request, Long key) {
		try{
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/			
			HttpSession session = request.getSession(false);
			UsuarioBean usuario = this.getWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/"+ key, request);
			session.setAttribute("usuario", usuario);
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

	@Get("/adicionar")
    public void formUsuario(MutableRequest request) {
		try{
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/
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
	
	@Get("/editar/{key}")
    public void formUsuario(MutableRequest request, Long key) {
		try{
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/		
			UsuarioBean usuario = this.getWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/"+ key, request);
			this.preserveRequest(usuario);
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
	
	@Get("/remover/{key}")
    public void usuario(MutableRequest request, Long key) {
		try{
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/
			this.getLoggedUser(request);
			this.deleteWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/"+key, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.removed", this.getResourceMessage("user.entity.name.display"), key, key));
			this.getResult().redirectTo("/usuario");			
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();		
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.usuario(request);
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}			
    }
	
	@Post("/confirmar-adicao")
	public void adicionar(UsuarioBean usuario, MutableRequest request) {
		try {
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/
			this.validateOperation(usuario, request, Operation.POST);
			UsuarioBean usuarioAlterado = this.postWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/", usuario, request);
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.created", this.getResourceMessage("user.entity.name.display"), usuarioAlterado.getLogin(), usuarioAlterado.getKey()));
			this.getResult().redirectTo("/usuario");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-adicao");
			this.preserveRequest(usuario);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/usuario/adicionar");
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}

	@Post("/confirmar-edicao")
	public void alterar(UsuarioBean usuario, MutableRequest request) {
		try {
			/*
			UsuarioBean u = this.getLoggedUser(request);
			if (!u.getKey().equals(1L)){
				this.getResult().include("msg_error", this.getResourceMessage("neurolaw.api.msg.error.usuario.unauthorized"));
				this.getResult().redirectTo("/");				
			}
			*/
			this.validateOperation(usuario, request, Operation.PUT);
			UsuarioBean usuarioAlterado = this.putWithCredentials(UsuarioBean.class, Util.getConfigProperty("neurolaw.api.msg.url")+"/usuario/"+usuario.getKey(), usuario, request);
			UsuarioBean usuarioSessao = this.getLoggedUser(request);
			if (usuarioSessao.getKey().equals(usuarioAlterado.getKey())){
				if (usuarioAlterado.getPassword ()==null){
					usuarioAlterado.setPassword (usuarioSessao.getPassword ());
				}
				this.setLoggedUser(usuarioAlterado, request);
			}
			this.getResult().include("msg_success", this.getResourceMessage("msg.act.entity.success.updated", this.getResourceMessage("user.entity.name.display"), usuario.getLogin(), usuario.getKey()));
			this.getResult().redirectTo("/usuario");
		} catch (UserSessionEndedException e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");			
		} catch (RequisicaoControllerException e) {
			e.printStackTrace();
			this.getResult().include("opAcao", "confirmar-edicao");
			this.preserveRequest(usuario);			
			this.getResult().include(this.getMessageType(e), e.getMessage());
			this.getResult().redirectTo("/usuario/editar/"+usuario.getKey());
		} catch (Exception e) {
			e.printStackTrace();
			this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			this.getResult().redirectTo("/");
		}
	}
	
	private void validateOperation(UsuarioBean usuario, MutableRequest request, Operation op){
		if (!op.equals(Operation.DELETE)){
			this.validateFields(usuario, "login", "nome", "cpf", "email", "telefone");
		}
		switch (op) {
		case POST:
			if (usuario.getPassword ()==null || usuario.getPassword ().isEmpty()){
				throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", this.getResourceMessage("password.field.name.display"), usuario.getDisplayName(), this.getResourceMessage("confirm.password.field.name.display"), usuario.getDisplayName()), "confirm.password.field.name.display");
			}
			if (request.getParameter("confirmarPassword ")==null || request.getParameter("confirmarPassword ").isEmpty()){
				throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", this.getResourceMessage("confirm.password.field.name.display"), usuario.getDisplayName(), this.getResourceMessage("confirm.password.field.name.display"), usuario.getDisplayName()), "confirm.password.field.name.display");
			}    			
			if (!usuario.getPassword ().equals(request.getParameter("confirmarPassword ").toString())){
				throw new CampoObrigatorioException(this.getResourceMessage("msg.error.usuario.password.divergence"), "msg.error.usuario.password.divergence");
			}				
			break;
		case PUT:
			if (usuario.getPassword ()!=null && !usuario.getPassword ().isEmpty()){
				if (request.getParameter("confirmarPassword ")==null || request.getParameter("confirmarPassword ").isEmpty()){
					throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", this.getResourceMessage("confirm.password.field.name.display"), usuario.getDisplayName(), this.getResourceMessage("confirm.password.field.name.display"), usuario.getDisplayName()), "confirm.password.field.name.display");
				}    			
				if (!usuario.getPassword ().equals(request.getParameter("confirmarPassword ").toString())){
					throw new CampoObrigatorioException(this.getResourceMessage("msg.error.usuario.password.divergence"), "msg.error.usuario.password.divergence");
				}				
			}else{
				usuario.setPassword (null);
			}
			break;
		case DELETE:
			if (usuario.getKey()==null){
				throw new CampoObrigatorioException(this.getResourceMessage("msg.act.required.field", this.getResourceMessage("key.field.name.display"), usuario.getDisplayName()), "msg.act.required.field");
			}    		
			break;
		default:
			throw new CampoObrigatorioException(this.getResourceMessage("msg.error.usuario.unsuported.operation"), "msg.error.usuario.unsuported.operation");
		}

	}

}