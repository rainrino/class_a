package com.secondproject.main.vo;

public class ProjectMgrVO {
	
	private String prj_code, prj_name;

	public ProjectMgrVO() {
	}

	public ProjectMgrVO(String prj_code, String prj_name) {
		this.prj_code = prj_code;
		this.prj_name = prj_name;
	}

	public String getPrj_code() {
		return prj_code;
	}

	public void setPrj_code(String prj_code) {
		this.prj_code = prj_code;
	}

	public String getPrj_name() {
		return prj_name;
	}

	public void setPrj_name(String prj_name) {
		this.prj_name = prj_name;
	}

}
