<%@page import="com.secondproject.dept.dao.DeptDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="부서 삭제하기 : 사용자가 선택한 부서를 DB에서 삭제하고, 부서 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
	//파라메터 값 받기 
	int deptNo=Integer.parseInt(request.getParameter("deptDelSelect"));
	
	//DB에 값 추가 
	DeptDAO dDao=DeptDAO.getInstance();
	
	dDao.deleteDept(deptNo); //삭제
	
	String msg="부서를 삭제했습니다.";
	
%>

alert("<%= msg %>");
location.href="dept.jsp"
</script>


