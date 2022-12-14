package io.neurolaw.adm.beans.cadastros;

import com.cmrevoredo.athena.restclient.entity.AthenaFormField;

import io.neurolaw.adm.beans.ConceptualBean;

public class UsuarioBean extends ConceptualBean{

	@AthenaFormField(isRequired=true)
	private String login;
	
	@AthenaFormField(isRequired=true)
	private String password;
	
	private EmpresaBean empresa;

	public UsuarioBean(){
	}
	
	public UsuarioBean(String login, String password, EmpresaBean empresa){
		super();
		this.login = login;
		this.password = password;
		this.empresa = empresa;
	}
	
	public String getLogin() {
		return login;
	}
	

	public void setLogin(String login) {
		this.login = login;
	}


	public String getPassword () {
		return password;
	}


	public void setPassword (String password) {
		this.password = password;
	}


	@Override
	public Object getCompareValue() {
		return this.getLogin();
	}

	public EmpresaBean getEmpresa() {
		return empresa;
	}

	public void setEmpresa(EmpresaBean empresa) {
		this.empresa = empresa;
	}

}
