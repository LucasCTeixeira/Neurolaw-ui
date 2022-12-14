package io.neurolaw.adm.beans;

import java.util.Date;
import java.util.ResourceBundle;

import com.cmrevoredo.athena.core.conversor.Conversor;

import br.com.caelum.vraptor.Convert;
import br.com.caelum.vraptor.Converter;

@Convert(Date.class)
public class DateConverter implements Converter<Date> {

	@Override
	public Date convert(String value, Class<? extends Date> arg1, ResourceBundle arg2) {
		// TODO Auto-generated method stub
		Date date = null;
		if (value.contains("/")) {
			if (value.length()>10){
				try {
					date = Conversor.convertStringToDate(value, "yyyy/MM/dd HH:mm"); 
				}catch(Exception e) {
					try {
						date = Conversor.convertStringToDate(value, "dd/MM/yyyy HH:mm"); 
					}catch(Exception e1) {
					}					
				}
			}else {
				try {
					date = Conversor.convertStringToDate(value, "yyyy/MM/dd");
				}catch(Exception e1) {
					try {
						date = Conversor.convertStringToDate(value, "dd/MM/yyyy");
					}catch(Exception e2) {
					}					
				}
			}
		}else {
			if (value.length()>10){
				try {
					date = Conversor.convertStringToDate(value, "yyyy-MM-dd HH:mm"); 
				}catch(Exception e) {
					try {
						date = Conversor.convertStringToDate(value, "dd-MM-yyyy HH:mm"); 
					}catch(Exception e1) {
					}
				}
			}else {
				try {
					date = Conversor.convertStringToDate(value, "yyyy-MM-dd");
				}catch(Exception e) {
					try {
						date = Conversor.convertStringToDate(value, "dd-MM-yyyy");
					}catch(Exception e1) {
					}				
				}				
			}
		}
		return date;
	}
}