package com.secondproject.emp.vo;

public class EmpCompleteVO {

	String empNo, empName, deptName, position, email, hiredate;

	EmpCompleteVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	EmpCompleteVO(String empNo, String empName, String deptName, String position, String email, String hiredate) {
		super();
		this.empNo = empNo;
		this.empName = empName;
		this.deptName = deptName;
		this.position = position;
		this.email = email;
		this.hiredate = hiredate;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	
}
