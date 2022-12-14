package io.neurolaw.adm.controlador;

import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.ioc.RequestScoped;

@Resource
@RequestScoped
public class IndexControlador extends ConceptualAuthControlador{

	public IndexControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
	}

	
	@Get("/")
	public void index(MutableRequest request) {
		HttpSession session = request.getSession(false);
		if (session.getAttribute(LOGGED_USER_ATTRIBUTE_SESSION)!=null) {
			this.getResult().redirectTo("/restrito");
		}
	}

}
