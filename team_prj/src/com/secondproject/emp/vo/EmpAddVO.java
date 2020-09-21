package com.secondproject.emp.vo;

public class EmpAddVO {

	String empNo, empName, position, deptName, email, hiredate;

	public EmpAddVO() {
	}

	public EmpAddVO(String empNo, String empName, String position, String deptName, String email, String hiredate) {
		super();
		this.empNo = empNo;
		this.empName = empName;
		this.position = position;
		this.deptName = deptName;
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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
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
