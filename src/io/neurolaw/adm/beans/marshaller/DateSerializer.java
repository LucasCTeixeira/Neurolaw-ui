package io.neurolaw.adm.beans.marshaller;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import io.neurolaw.adm.Util;

public class DateSerializer extends JsonSerializer<Date> {

	@Override
	public void serialize(Date date, JsonGenerator jgen, SerializerProvider provider){
		SimpleDateFormat formatter = new SimpleDateFormat(Util.JSON_DATE_FORMAT);
		String format = formatter.format(date);
		try {
			jgen.writeString(format);
		}catch(Exception e){
			System.out.println("Failed to parse Date (Value: " + date + ") due to:" + e.getMessage());
			e.printStackTrace();
            throw new RuntimeException(e);
		}
	}
}