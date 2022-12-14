package io.neurolaw.adm.beans.cadastros;

import io.neurolaw.adm.beans.ConceptualBean;

public class MetadataBean extends ConceptualBean{
	private float page;
	private float page_size;
	private float total;
	
	public float getPage() {
		return page;
	}
	public void setPage(float page) {
		this.page = page;
	}
	public float getPage_size() {
		return page_size;
	}
	public void setPage_size(float page_size) {
		this.page_size = page_size;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	
	@Override
	public Object getCompareValue() {
		return 0;
	}
}
