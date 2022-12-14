package io.neurolaw.adm.beans.cadastros;

import com.cmrevoredo.athena.restclient.entity.AthenaFormField;

import io.neurolaw.adm.beans.ConceptualBean;

public class EmpresaBean extends ConceptualBean{

	@AthenaFormField(isRequired=true)
	private String nome;


	public EmpresaBean(){
	}
	
	public EmpresaBean(String nome){
		this.nome = nome;
	}

	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	@Override
	public Object getCompareValue() {
		return this.getNome();
	}

}
