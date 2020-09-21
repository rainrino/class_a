package com.secondproject.emp.vo;

public class PositionVO {

	private String position, position_no;

	public PositionVO() {
	}

	public PositionVO(String position, String position_no) {
		super();
		this.position = position;
		this.position_no = position_no;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPosition_no() {
		return position_no;
	}

	public void setPosition_no(String position_no) {
		this.position_no = position_no;
	}

}
