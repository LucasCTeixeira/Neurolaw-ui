package io.neurolaw.adm.beans;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import br.com.caelum.vraptor.interceptor.TypeNameExtractor;
import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.serialization.ProxyInitializer;
import br.com.caelum.vraptor.serialization.xstream.XStreamBuilder;
import br.com.caelum.vraptor.serialization.xstream.XStreamJSONSerialization;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.converters.SingleValueConverter;

@Component  
public class VRaptorJsonSerializeDateTimeAdapter extends XStreamJSONSerialization {  
        
    public VRaptorJsonSerializeDateTimeAdapter(HttpServletResponse response,TypeNameExtractor extractor, ProxyInitializer initializer, XStreamBuilder builder) {  
        super(response, extractor, initializer, builder); 
    }  
         
    @Override  
    public XStream getXStream() {  
        @SuppressWarnings("deprecation")
		XStream xstream = super.getXStream();  
        xstream.registerConverter(new   SingleValueConverter() {  
  
           public String toString(Object value) {  
                 return new  SimpleDateFormat("dd-MM-yyyy'T'HH:mm:ss").format(value);  
           }  
  
           public boolean canConvert(@SuppressWarnings("rawtypes") Class clazz) {  
                return Date.class.isAssignableFrom(clazz);  
           }  
  
           public Object fromString(String value) {  
              return null; //não é usado  
           }  
        });   
        return xstream;  
    }  
}  