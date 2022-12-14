package io.neurolaw.adm.beans;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name="msg")
public class MensagemRespostaBean extends ConceptualBean{
	private String message;
	private int statusCode;
	
	public MensagemRespostaBean(){
	}

	public MensagemRespostaBean(int statusCode, String messagem){
		this.statusCode = statusCode;
		this.message = messagem;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	@Override
	public Object getCompareValue() {
		return this.getMessage();
	}

}
