package com.secondproject.dept.vo;

public class ModifyDeptVO {
	private String deptName; 
	private int deptNo;
	
	public ModifyDeptVO() {
	}
	
	public ModifyDeptVO(String deptName, int deptNo) {
		this.deptName = deptName;
		this.deptNo = deptNo;
	}
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public int getDeptNo() {
		return deptNo;
	}
	
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}

	
}//class
