package io.neurolaw.adm.beans.marshaller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.ResourceBundle;

import br.com.caelum.vraptor.Convert;
import br.com.caelum.vraptor.Converter;
import br.com.caelum.vraptor.ioc.ApplicationScoped;
import io.neurolaw.adm.Util;

@Convert(Date.class)
@ApplicationScoped
public class VRaptorDateConverter implements Converter<Date> {

    public Date convert(String value, Class<? extends Date> type, ResourceBundle bundle) {
		if (value == null || value.isEmpty()) {
			return null;
		}
		
		String format_date = null;
	    String format_date_time = null;
	    
	    //*************************
	    //** AJUSTAR PARA DINAMICAMENTE
	    //*************************
	    //String locale = Locale.getDefault().toString();
	    String locale = new Locale("pt", "BR").toString();
	    
	    switch (locale) {
		case "pt_BR":
			format_date = Util.INPUT_DATE_FORMAT_PT_BR;
			format_date_time = Util.INPUT_DATE_TIME_FORMAT_PT_BR;
			break;
		case "en_US":
			format_date = Util.INPUT_DATE_FORMAT_EN_US;
			format_date_time = Util.INPUT_DATE_TIME_FORMAT_EN_US;
			break;
		default:
			break;
		}
	    
		SimpleDateFormat formatter = new SimpleDateFormat(format_date_time);
		try {
			return formatter.parse(value);
		} catch (ParseException pe) {
			formatter = new SimpleDateFormat(format_date);
			try {
				return formatter.parse(value);
			} catch (ParseException pe1) {
				throw new RuntimeException();
			}
		}
    }
}