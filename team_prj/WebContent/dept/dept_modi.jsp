<%@page import="com.secondproject.dept.vo.ModifyDeptVO"%>
<%@page import="com.secondproject.dept.dao.DeptDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="부서 수정하기 : 사용자가 수정한 부서명을 DB에 넣고, 부서 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
	//파라메터 값 받기 
	String deptName=request.getParameter("deptInsertDeptName");
	String deptNo=request.getParameter("deptModiSelect");
	
	ModifyDeptVO mdVO=new ModifyDeptVO();
	//파라메터 값 받기 
	mdVO.setDeptName(deptName);
	mdVO.setDeptNo(Integer.parseInt(deptNo));
	
	
	//값 수정 뒤 DB에 추가 
	DeptDAO dDao=DeptDAO.getInstance();
	
	dDao.updateDept(mdVO); //수정
	
	String msg="부서명이 수정되었습니다.";
	
%>

alert("<%= msg %>");
location.href="dept.jsp"
</script>


