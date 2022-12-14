package io.neurolaw.adm.beans.marshaller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import io.neurolaw.adm.Util;

public class DateDeserializer extends JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonParser jsonParser,
            DeserializationContext deserializationContext) throws IOException,
            JsonProcessingException {
        SimpleDateFormat formatter = new SimpleDateFormat(Util.JSON_DATE_FORMAT);
        String date = jsonParser.getText();
        
		try{
			return formatter.parse(date);
		}catch(Exception e){
			System.out.println("Failed to parse Date (Value: " + date + ") due to:" + e.getMessage());
			e.printStackTrace();
            throw new RuntimeException(e);
		}
    }
}