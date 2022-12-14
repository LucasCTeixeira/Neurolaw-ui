package io.neurolaw.adm;

import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import com.cmrevoredo.athena.core.br.formatacao.Formatador;
import com.cmrevoredo.athena.core.formatting.Formatter;

import io.neurolaw.adm.beans.cadastros.UsuarioBean;


public final class Util {
	
	public static String JSON_DATE_FORMAT = "yyyy-MM-dd";
	public static String JSON_DATETIME_FORMAT = "yyyy-MM-dd HH:mm";
	public static String JSON_DATE_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";
	public static String JSON_DATE_TIME_FORMAT_FULL = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

	public static String INPUT_DATE_FORMAT_PT_BR = "dd/MM/yyyy";
	public static String INPUT_DATE_TIME_FORMAT_PT_BR = "dd/MM/yyyy HH:mm";
	public static String INPUT_DATE_FORMAT_EN_US = "MM/dd/yyyy";
	public static String INPUT_DATE_TIME_FORMAT_EN_US = "MM/dd/yyyy HH:mm";
	
	public static String getConfigProperty(String propertyName){
		//URL appPath = Util.class.getClassLoader().getResource("");
		//String path = appPath.getPath().replace("/C:", "C:")+"app.properties";
		Properties properties = new Properties();
		try{
			//properties.load(new FileInputStream(path));
			properties.load(Util.class.getClassLoader().getResourceAsStream("app.properties"));
		}catch(IOException e){
			e.printStackTrace();
		}
		return properties.getProperty(propertyName);
	}
	
	public static String mascararCPF(String cpf){
		return Formatador.adicionarMascaraCPF(cpf);	
	}

	public static String mascararCNPJ(String cnpj){
		return Formatador.adicionarMascaraCNPJ(cnpj);
	}

	public static String formatarCurrencyBR(Double valor, Integer decimais){
		return Formatter.addCurrencyMask(valor, new Locale("pt", "BR"), decimais, true);
	}

	public static String formatarFloatBR(Double valor, Integer decimais){
		return Formatter.addCurrencyMask(valor, new Locale("pt", "BR"), decimais, false);
	}
	
	public boolean isExibirPainel(UsuarioBean usuario){
		return (usuario!=null);
	}

}
