package com.secondproject.process.vo;

public class UpdateProcessVO {
	
	private String projectName, old_prj_name, projectMgr, deptName, processName, start_date, complete_date, note, processCode;
	private int working_days;
	
	public UpdateProcessVO() {
	}

	public UpdateProcessVO(String projectName, String old_prj_name,
			String projectMgr, String deptName, String processName,
			String start_date, String complete_date, String note,
			String processCode, int working_days) {
		super();
		this.projectName = projectName;
		this.old_prj_name = old_prj_name;
		this.projectMgr = projectMgr;
		this.deptName = deptName;
		this.processName = processName;
		this.start_date = start_date;
		this.complete_date = complete_date;
		this.note = note;
		this.processCode = processCode;
		this.working_days = working_days;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getOld_prj_name() {
		return old_prj_name;
	}

	public void setOld_prj_name(String old_prj_name) {
		this.old_prj_name = old_prj_name;
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

	public String getProcessCode() {
		return processCode;
	}

	public void setProcessCode(String processCode) {
		this.processCode = processCode;
	}

	public int getWorking_days() {
		return working_days;
	}

	public void setWorking_days(int working_days) {
		this.working_days = working_days;
	}

	@Override
	public String toString() {
		return "UpdateProcessVO [projectName=" + projectName + ", old_prj_name="
				+ old_prj_name + ", projectMgr=" + projectMgr + ", deptName="
				+ deptName + ", processName=" + processName + ", start_date="
				+ start_date + ", complete_date=" + complete_date + ", note="
				+ note + ", processCode=" + processCode + ", working_days="
				+ working_days + "]";
	}
	
	
}

