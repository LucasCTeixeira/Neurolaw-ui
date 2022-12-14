package io.neurolaw.adm.controlador;

import java.util.Locale;

import javax.servlet.jsp.jstl.core.Config;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.Localization;
import br.com.caelum.vraptor.http.MutableRequest;
import br.com.caelum.vraptor.http.MutableResponse;
import br.com.caelum.vraptor.view.Results;
import io.neurolaw.adm.beans.MensagemRespostaBean;

@Resource
@Path("/config")
public class ConfigControlador extends ConceptualControlador{
	
	private String LOCALE_SESSION_CHOSEN = "localeChosen";
	
	public ConfigControlador(Result result, br.com.caelum.vraptor.Validator validator, Localization localization, MutableRequest request) {
		super(result, validator, localization, request);
	}

	@Get("/AlterarIdioma/{language}")
    public void changeLanguage(String language, MutableRequest request, MutableResponse response) {		
		try {
			Locale locale = null;
			switch (language) {
			case "pt_BR":
				locale = new Locale("pt", "BR");
				break;
			case "en_US":
				locale = new Locale("en", "US");
				break;
			default:
				//locale = Locale.getDefault();
				locale = new Locale("pt", "BR");
				break;
			}
			request.getSession().setAttribute(LOCALE_SESSION_CHOSEN, locale.getLanguage()+"_"+locale.getCountry());
			Config.set(request.getSession(), Config.FMT_LOCALE, locale);
			Config.set(request.getSession(), Config.FMT_FALLBACK_LOCALE, locale);
			response.setHeader("Content-Language", locale.getLanguage());
			MensagemRespostaBean msg = new MensagemRespostaBean(200, "success");
    		this.getResult().use(Results.json()).withoutRoot().from(msg).recursive().serialize();			
		} catch (Exception e) {
			//this.getResult().include("msg_error", this.getResourceMessage("msg.unexpected.error", e.getMessage()));
			//e.printStackTrace();			
			MensagemRespostaBean msg = new MensagemRespostaBean(500, this.getResourceMessage("msg.unexpected.error", e.getMessage()));
    		this.getResult().use(Results.json()).withoutRoot().from(msg).recursive().serialize();			
		}
		//this.getResult().redirectTo("/");
    }
}