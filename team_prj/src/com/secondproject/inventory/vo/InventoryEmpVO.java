package com.secondproject.inventory.vo;

public class InventoryEmpVO {

	private String empNo,empName;

	public InventoryEmpVO() {
		super();
	}

	public InventoryEmpVO(String empNo, String empName) {
		super();
		this.empNo = empNo;
		this.empName = empName;
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
	
	
}
