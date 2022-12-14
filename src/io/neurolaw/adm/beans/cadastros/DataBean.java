package io.neurolaw.adm.beans.cadastros;

import java.util.List;

import io.neurolaw.adm.beans.ConceptualBean;

public class DataBean extends ConceptualBean{
	private List<AcordoBean> data;
	private MetadataBean metadata;
	public List<AcordoBean> getData() {
		return data;
	}
	public void setData(List<AcordoBean> data) {
		this.data = data;
	}
	public MetadataBean getMetadata() {
		return metadata;
	}
	public void setMetadata(MetadataBean metadata) {
		this.metadata = metadata;
	}
	
	@Override
	public Object getCompareValue() {
		return 0;
	}
}
