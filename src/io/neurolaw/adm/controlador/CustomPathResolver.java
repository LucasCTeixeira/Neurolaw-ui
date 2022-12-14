package io.neurolaw.adm.controlador;

import br.com.caelum.vraptor.http.FormatResolver;
import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.view.DefaultPathResolver;

@Component  
public class CustomPathResolver extends DefaultPathResolver {  
      
    public CustomPathResolver(FormatResolver resolver) {
		super(resolver);
	}

	@Override  
    protected String getPrefix() {  
        return "/WEB-INF/";  
    }  
      
    @Override  
    protected String getExtension() {  
        return "jsp"; // ou qualquer outra extensão  
    }  
  
    @Override  
    protected String extractControllerFromName(String baseName) {
    	String path = "/jsp/";
    	switch (baseName) {    	
		case "RestritoControlador":
			path += "restrito/";
			break;
		case "UsuarioControlador":
		case "AcordoControlador":
		case "ArquivoControlador":
			path += "restrito/cadastros/";
			break;
		default:
		}
    	return path;
    }  
  
}  