package com.secondproject.process.vo;

/**
 * ����ڰ� ������Ʈ���� ��ȸ�ϴ� ��
 * @author sist27
 *
 */
public class ProjectVO {

	private String prj_name, prj_code ; 
	
	public ProjectVO() {
	}

	public ProjectVO(String prj_name, String prj_code) {
		this.prj_name = prj_name;
		this.prj_code = prj_code;
	}

	public String getPrj_name() {
		return prj_name;
	}

	public void setPrj_name(String prj_name) {
		this.prj_name = prj_name;
	}

	public String getPrj_code() {
		return prj_code;
	}

	public void setPrj_code(String prj_code) {
		this.prj_code = prj_code;
	}
	
	
}
