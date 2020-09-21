package com.secondproject.emp.vo;

public class DeptVO {

	private String dept_name; 
	private int dept_no;

	public DeptVO() {
		// TODO Auto-generated constructor stub
	}

	public DeptVO(String dept_name, int dept_no) {
		this.dept_name = dept_name;
		this.dept_no = dept_no;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public int getDept_no() {
		return dept_no;
	}

	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
}
