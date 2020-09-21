package com.secondproject.dept.vo;

public class DeptVO {
	private String deptName, deptNo;

	public DeptVO() {
	}

	public DeptVO(String deptName, String deptNo) {
		super();
		this.deptName = deptName;
		this.deptNo = deptNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}

	
}//class
