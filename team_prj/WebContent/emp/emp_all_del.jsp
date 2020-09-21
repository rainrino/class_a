<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.emp.vo.EmpDelVO"%>
<%@page import="com.secondproject.emp.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

<%
	EmpDelVO edVO = new EmpDelVO();
	
	edVO.setEmail(request.getParameter("email"));
	EmpDAO eDao = EmpDAO.getInstance();
	String msg = "???????";
	int cnt = 0;
	try{
		cnt = eDao.deleteUser(edVO);
		System.out.println(cnt);
		if(cnt == 1){
			msg = "사원 정보 삭제 성공하였습니다.";
		}
	}catch(NullPointerException e){
		e.printStackTrace();
		msg="사원 정보 삭제 실패하였습니다.";
	}catch(SQLException e){
		e.printStackTrace();
		msg="문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
	}
%>
	alert("<%=msg%>");
	location.href="emp_all.jsp";
</script>