package com.secondproject.process.vo;

public class InsertProcesssVO {
	
	private String projectName, projectMgr, deptName, processName, start_date, complete_date, note;
	private int  working_days;
	
	public InsertProcesssVO() {
	}

	public InsertProcesssVO(String projectName, String projectMgr,
			String deptName, String processName, String start_date,
			String complete_date, String note, int working_days) {
		this.projectName = projectName;
		this.projectMgr = projectMgr;
		this.deptName = deptName;
		this.processName = processName;
		this.start_date = start_date;
		this.complete_date = complete_date;
		this.note = note;
		this.working_days = working_days;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectMgr() {
		return projectMgr;
	}

	public void setProjectMgr(String projectMgr) {
		this.projectMgr = projectMgr;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getProcessName() {
		return processName;
	}

	public void setProcessName(String processName) {
		this.processName = processName;
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public int getWorking_days() {
		return working_days;
	}

	public void setWorking_days(int working_days) {
		this.working_days = working_days;
	}

	
	
}
