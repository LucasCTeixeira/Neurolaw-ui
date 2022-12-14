package io.neurolaw.adm.controlador;

import java.util.List;

import io.neurolaw.adm.beans.ConceptualBean;

public class PagingResultsBean<T extends ConceptualBean> {
	protected int page;
	private int pageCount;
	private int size;
	private int firstResult;
	private int lastResult;
	public Double rowCount;
	private String queryString;
	private List<T> results;

	public PagingResultsBean(int page, int size, Double rowCount, List<T> results, String queryString) {
		super();
		this.page = page;
		this.size = size;
		this.rowCount = rowCount;
		this.results = results;
		this.queryString = queryString;
		this.build();
	}

	private void build(){
		pageCount = 1;
		size = 10;
		firstResult = 0;
		lastResult = 0;
		if (rowCount>0){
			double pages = (rowCount/size) + 0.4;
			pageCount = (int)Math.round(pages);
			firstResult = (size * page) - size;
			lastResult = firstResult + size;
			if (page==pageCount){
				lastResult = lastResult - (lastResult - rowCount.intValue()); 
			}				
		}else{
			firstResult = -1;
		}
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getFirstResult() {
		return firstResult;
	}

	public void setFirstResult(int firstResult) {
		this.firstResult = firstResult;
	}

	public int getLastResult() {
		return lastResult;
	}

	public void setLastResult(int lastResult) {
		this.lastResult = lastResult;
	}

	public Double getRowCount() {
		return rowCount;
	}

	public void setRowCount(Double rowCount) {
		this.rowCount = rowCount;
	}

	public List<T> getResults() {
		return results;
	}

	public void setResults(List<T> results) {
		this.results = results;
	}

	public String getQueryString() {
		return queryString;
	}

	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

}
