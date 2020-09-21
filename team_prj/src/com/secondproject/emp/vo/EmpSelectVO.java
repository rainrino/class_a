package com.secondproject.emp.vo;

public class EmpSelectVO {

	String emp_no, emp_name, position, dept_name, email, hiredate;

	EmpSelectVO() {
		
	}

	public EmpSelectVO(String emp_no, String emp_name, String position, String dept_name, String email,
			String hiredate) {
		super();
		this.emp_no = emp_no;
		this.emp_name = emp_name;
		this.position = position;
		this.dept_name = dept_name;
		this.email = email;
		this.hiredate = hiredate;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
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
