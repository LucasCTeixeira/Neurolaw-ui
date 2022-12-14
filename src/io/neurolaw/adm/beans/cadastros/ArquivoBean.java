package io.neurolaw.adm.beans.cadastros;


import io.neurolaw.adm.beans.ConceptualBean;

public class ArquivoBean extends ConceptualBean{
	
	private String id;
	private String filename;
	private String description;
	private byte[] arquivo;
	private String hash;
	
	public ArquivoBean() {
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getFilename() {
		return filename;
	}
	
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public byte[] getArquivo() {
		return arquivo;
	}
	
	public void setArquivo(byte[] arquivo) {
		this.arquivo = arquivo;
	}
	
	public String getHash() {
		return hash;
	}
	
	public void setHash(String hash) {
		this.hash = hash;
	}

	@Override
	public Object getCompareValue() {
		return null;
	}
}
