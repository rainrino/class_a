<%@page import="com.secondproject.dept.dao.DeptDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="부서 추가하기 : 사용자가 입력한 값을 DB에 넣고, 부서 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
	//파라메터 값 받기 
	String deptName=request.getParameter("deptName");
	
	//DB에 값 추가 
	DeptDAO dDao=DeptDAO.getInstance();
	
	dDao.insertDept(deptName); //추가
	
	String msg="부서 리스트에\t"+deptName+"\t를 추가했습니다.";
	
%>

alert("<%= msg %>");
location.href="dept.jsp"
</script>


