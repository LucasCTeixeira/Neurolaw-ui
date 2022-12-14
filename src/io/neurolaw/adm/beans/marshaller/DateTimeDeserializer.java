package io.neurolaw.adm.beans.marshaller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import io.neurolaw.adm.Util;

public class DateTimeDeserializer extends JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonParser jsonParser,
            DeserializationContext deserializationContext) throws IOException,
            JsonProcessingException {
        SimpleDateFormat formatter = new SimpleDateFormat(Util.JSON_DATE_TIME_FORMAT);
        String date = jsonParser.getText();
		try{
			Date result = null;
			try{
				result = formatter.parse(date);
			}catch(Exception e){
				formatter = new SimpleDateFormat(Util.JSON_DATE_FORMAT);
				result = formatter.parse(date);
			}
		    Calendar calendar = Calendar.getInstance();
		    calendar.setTimeZone(TimeZone.getTimeZone("GMT"));
		    calendar.setTime(result);
		    //calendar.set(Calendar.SECOND, 0);
		    //calendar.set(Calendar.MILLISECOND, 0);		
		    //calendar.set(Calendar.HOUR, -3);
			return calendar.getTime();
		}catch(Exception e){
			System.out.println("Failed to parse DateTime (Value: " + date + ") due to:" + e.getMessage());
			e.printStackTrace();
            throw new RuntimeException(e);
		}
    }
}