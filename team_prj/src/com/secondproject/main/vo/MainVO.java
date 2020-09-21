package com.secondproject.main.vo;

public class MainVO {

	private String process_code, prj_code, process_name, start_date, complete_date;

	public MainVO() {
	}

	public MainVO(String process_code, String prj_code, String process_name, String start_date, String complete_date) {
		this.process_code = process_code;
		this.prj_code = prj_code;
		this.process_name = process_name;
		this.start_date = start_date;
		this.complete_date = complete_date;
	}

	public String getProcess_code() {
		return process_code;
	}

	public void setProcess_code(String process_code) {
		this.process_code = process_code;
	}

	public String getPrj_code() {
		return prj_code;
	}

	public void setPrj_code(String prj_code) {
		this.prj_code = prj_code;
	}

	public String getProcess_name() {
		return process_name;
	}

	public void setProcess_name(String process_name) {
		this.process_name = process_name;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getComplete_date() {
		return complete_date;
	}

	public void setComplete_date(String complete_date) {
		this.complete_date = complete_date;
	}
	
}
