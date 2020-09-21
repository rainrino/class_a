package com.secondproject.project.vo;

public class ProjectVO {
	private String prjName, startdate, enddate, prjMng;

	public ProjectVO() {
	}

	public ProjectVO(String prjName, String startdate, String enddate, String prjMng) {
		this.prjName = prjName;
		this.startdate = startdate;
		this.enddate = enddate;
		this.prjMng = prjMng;
	}

	public String getPrjName() {
		return prjName;
	}

	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getPrjMng() {
		return prjMng;
	}

	public void setPrjMng(String prjMng) {
		this.prjMng = prjMng;
	}
	
	
}
