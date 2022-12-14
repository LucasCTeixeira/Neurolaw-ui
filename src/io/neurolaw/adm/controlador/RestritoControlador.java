package io.neurolaw.adm.controlador;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.ioc.RequestScoped;
import io.neurolaw.adm.controlador.exception.RequisicaoControllerException;
import io.neurolaw.adm.controlador.exception.UserSessionEndedException;

@Resource
@Path("/restrito")
@RequestScoped
public class RestritoControlador extends ConceptualAuthControlador{

	public RestritoControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
	}
	
	@Get("/")
    public void logado(MutableRequest request) {
		try{
			this.getLoggedUser(request);
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

}
