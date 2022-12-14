package io.neurolaw.adm.beans.cadastros;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import io.neurolaw.adm.beans.ConceptualBean;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ErroBean extends ConceptualBean{
	private String timestamp;
	private int status;
	private String error;
	private String message;
	private String path;
	
	public ErroBean() {
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Override
	public Object getCompareValue() {
		return this.timestamp;
	}
	
	
}
