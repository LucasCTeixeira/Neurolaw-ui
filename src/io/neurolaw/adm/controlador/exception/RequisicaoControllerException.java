package io.neurolaw.adm.controlador.exception;

import javax.ws.rs.WebApplicationException;

import io.neurolaw.adm.beans.MensagemRespostaBean;

public class RequisicaoControllerException extends WebApplicationException {
	private static final long serialVersionUID = 1L;
	private MensagemRespostaBean mensagem;
	private String chave;
	
	public RequisicaoControllerException(int statusCode, String menssagem, String chave){
		super(statusCode);
		this.mensagem = new MensagemRespostaBean(statusCode, menssagem);
		this.chave = chave;
	}

	public RequisicaoControllerException(MensagemRespostaBean mensagemRespostaBean, String chave){
		this(mensagemRespostaBean.getStatusCode(), mensagemRespostaBean.getMessage(), chave);
	}
	
	public int getStatusCode(){
		return this.mensagem.getStatusCode();
	}

	public String getMessage(){
		return this.mensagem.getMessage();
	}

	public String getChave() {
		return chave;
	}
}