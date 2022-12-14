package io.neurolaw.adm.beans.cadastros;

import java.util.Date;

import com.cmrevoredo.athena.restclient.entity.AthenaFormField;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import io.neurolaw.adm.beans.ConceptualBean;
import io.neurolaw.adm.beans.marshaller.DateTimeDeserializer;
import io.neurolaw.adm.beans.marshaller.DateTimeSerializer;

public class ArquivoVersaoBean extends ConceptualBean{

	@AthenaFormField(isRequired=true)
	private String descricao;
	private EmpresaBean autor;
	@JsonSerialize(using=DateTimeSerializer.class)
	@JsonDeserialize(using=DateTimeDeserializer.class)
	private Date data;


	public ArquivoVersaoBean(){
	}

	

	public String getDescricao() {
		return descricao;
	}



	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}



	public EmpresaBean getAutor() {
		return autor;
	}



	public void setAutor(EmpresaBean autor) {
		this.autor = autor;
	}



	public Date getData() {
		return data;
	}



	public void setData(Date data) {
		this.data = data;
	}



	@Override
	public Object getCompareValue() {
		return this.getDescricao();
	}

}
