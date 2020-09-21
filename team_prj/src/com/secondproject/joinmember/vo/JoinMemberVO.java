package com.secondproject.joinmember.vo;

public class JoinMemberVO {
	private String empName, password, email;

	public JoinMemberVO() {
	}

	public JoinMemberVO(String empName, String password, String email) {
		this.empName = empName;
		this.password = password;
		this.email = email;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
}//class
