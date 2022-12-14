package io.neurolaw.adm.filters;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.jstl.core.Config;

public abstract class ConceptualFilter {
    public String getResourceMessage(HttpServletRequest request, String key, Object[] args){
    	String msg = null;
    	try{
    		msg = new String(this.getResourceBundle(request).getString(key).getBytes("ISO-8859-1"), "UTF-8");
    	}catch(Exception e){
    		msg = this.getResourceBundle(request).getString(key);
    	}
    	return MessageFormat.format(msg, args);
    	
    	
    }
    
    public ResourceBundle getResourceBundle(HttpServletRequest request){
		Locale locale = new Locale("pt", "BR");
		if (Config.get(request.getSession(), Config.FMT_LOCALE)!=null){
			locale = (Locale)Config.get(request.getSession(), Config.FMT_LOCALE);
		}
	    return ResourceBundle.getBundle("io.neurolaw.adm.nf.i18n.messages", locale);    	
    }
}
