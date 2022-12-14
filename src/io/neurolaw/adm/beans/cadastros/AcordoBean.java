package io.neurolaw.adm.beans.cadastros;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import io.neurolaw.adm.beans.ConceptualBean;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AcordoBean extends ConceptualBean{
	private String agreementId;
	private String agreementName;
	private List<String> participants;
	private String agreementStatus;
	//@JsonSerialize(using=DateTimeSerializer.class)
	//@JsonDeserialize(using=DateTimeDeserializer.class)
	private String creationDate;
	private String expirationDate = null;
	private List<ArquivoBean> attachments;
	
	public AcordoBean(){
		this.participants = new ArrayList<String>();
		this.attachments = new ArrayList<ArquivoBean>();
	}

	public String getAgreementId() {
		return agreementId;
	}

	public void setAgreementId(String agreementId) {
		this.agreementId = agreementId;
	}

	public String getAgreementName() {
		return agreementName;
	}

	public void setAgreementName(String agreementName) {
		this.agreementName = agreementName;
	}

	public List<String> getParticipants() {
		return participants;
	}

	public void setParticipants(List<String> participants) {
		this.participants = participants;
	}

	public String getAgreementStatus() {
		return agreementStatus;
	}

	public void setAgreementStatus(String agreementStatus) {
		this.agreementStatus = agreementStatus;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public List<ArquivoBean> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<ArquivoBean> attachments) {
		this.attachments = attachments;
	}

	@Override
	public Object getCompareValue() {
		return this.getAgreementId();
	}
	
}
