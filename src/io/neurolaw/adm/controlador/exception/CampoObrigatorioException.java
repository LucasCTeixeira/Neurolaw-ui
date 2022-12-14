package io.neurolaw.adm.controlador.exception;

public class CampoObrigatorioException extends RequisicaoControllerException {
	private static final long serialVersionUID = 1L;

	public CampoObrigatorioException(String msg, String chave){
		super(500, msg, chave);
	}
}