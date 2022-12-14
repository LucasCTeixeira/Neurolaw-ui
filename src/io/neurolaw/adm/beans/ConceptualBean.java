package io.neurolaw.adm.beans;

import java.util.Date;

import br.com.caelum.vraptor.util.StringUtils;

import com.cmrevoredo.athena.core.conversor.Conversor;
import com.cmrevoredo.athena.core.conversor.exception.ConversorException;
import com.cmrevoredo.athena.core.validator.Validator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown=true)
@JsonPropertyOrder(alphabetic=true)
public abstract class ConceptualBean implements Comparable<ConceptualBean>{
	private Long key;
	private Boolean active;
	
	public abstract Object getCompareValue();
	
	public Long getKey() {
		return key;
	}

	public void setKey(Long key) {
		this.key = key;
	}
	
	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getJsonType(){
		return StringUtils.decapitalize(this.getClass().getSimpleName().replace("Bean", ""));
	}

	public String getDisplayName(){
		return this.getClass().getSimpleName().replace("Bean", "");
	}
	
	public boolean equals(Object obj) {
	    if (obj instanceof ConceptualBean) {
	        ConceptualBean o = (ConceptualBean)obj;
	        if (o.getKey()!=null && this.getKey()!=null) {
	        	return o.getKey().equals(this.getKey());
	        }
	    }
	    return false;
	}

	@Override
	public int compareTo(ConceptualBean c) {
		int result = 0;
		
		if (this.getCompareValue()==null){
			result = -1;
		}
		
		if (this.getCompareValue()!=null){
			if (this.getCompareValue() instanceof Date){
				if (((Date)this.getCompareValue()).after((Date)c.getCompareValue())){
					result = -1;
				}
				if (((Date)this.getCompareValue()).before((Date)c.getCompareValue())){
					result = 1;
				}
			}
			
			if (Validator.isValidNumeric(this.getCompareValue().toString())) {
				try {
					Double val1 = Conversor.convertStringToDouble(this.getCompareValue().toString());
					Double val2 = Conversor.convertStringToDouble(c.getCompareValue().toString());
					if (val1 < val2){
						result = -1;
					}
					if (val1 > val2){
						result = 1;
					}
				} catch (ConversorException e) {
				}
			}
			
			if (this.getCompareValue() instanceof String){
				result = this.getCompareValue().toString().compareToIgnoreCase(c.getCompareValue().toString());
			}
		}
		return result;
	}
}
