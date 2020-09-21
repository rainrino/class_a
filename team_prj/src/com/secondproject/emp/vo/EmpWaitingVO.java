package com.secondproject.emp.vo;

public class EmpWaitingVO {

	String empName, email;

	EmpWaitingVO() {
	}

	EmpWaitingVO(String empName, String email) {
		this.empName = empName;
		this.email = email;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
}
