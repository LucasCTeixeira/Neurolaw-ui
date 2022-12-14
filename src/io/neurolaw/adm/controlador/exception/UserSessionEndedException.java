package io.neurolaw.adm.controlador.exception;

import io.neurolaw.adm.beans.MensagemRespostaBean;

public class UserSessionEndedException extends RequisicaoControllerException {
	private static final long serialVersionUID = 1L;

	public UserSessionEndedException(int statusCode, String menssagem, String chave){
		super(new MensagemRespostaBean(statusCode, menssagem), chave);
	}

	public UserSessionEndedException(MensagemRespostaBean mensagemRespostaBean, String chave){
		this(mensagemRespostaBean.getStatusCode(), mensagemRespostaBean.getMessage(), chave);
	}
}