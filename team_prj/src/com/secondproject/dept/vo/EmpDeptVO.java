package com.secondproject.dept.vo;

public class EmpDeptVO {
	private String position, empName;

	public EmpDeptVO() {
	}

	public EmpDeptVO(String position, String empName) {
		this.position = position;
		this.empName = empName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	
}//class 
