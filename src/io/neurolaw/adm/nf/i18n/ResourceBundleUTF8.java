package io.neurolaw.adm.nf.i18n;

import java.util.Enumeration;
import java.util.Locale;
import java.util.ResourceBundle;

public class ResourceBundleUTF8 extends ResourceBundle {
	
	protected Locale locale;
	protected String BUNDLE_NAME = "io.neurolaw.adm.nf.i18n.messages";
	protected String CHARSET_ISO_8859_1 = "ISO-8859-1";
	protected String CHARSET_UTF8 = "UTF-8";

	public ResourceBundleUTF8() {
		//this.locale = Locale.getDefault();
		this.locale = new Locale("pt", "BR");
	}
	
	public ResourceBundleUTF8(Locale locale) {
		this.locale = locale;
	}

    @Override
    protected Object handleGetObject(String key) {
    	if (locale==null){
    		//locale = Locale.getDefault();
    		locale = new Locale("pt", "BR");
    	}
    	setParent(ResourceBundle.getBundle(BUNDLE_NAME, locale));
    	Object msg = parent.getObject(key);
    	if (msg!=null && msg instanceof String){
        	try{
        		return new String(msg.toString().getBytes(CHARSET_ISO_8859_1), CHARSET_UTF8);
        	}catch(Exception e){
        	}    		
    	}
    	return msg;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
    public Enumeration getKeys() {
        return parent.getKeys();
    }
}