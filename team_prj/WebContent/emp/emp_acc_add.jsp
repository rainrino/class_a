<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.emp.dao.EmpDAO"%>
<%@page import="com.secondproject.emp.vo.EmpAddVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
<%
EmpAddVO eaVO = new EmpAddVO();

eaVO.setEmpName(request.getParameter("empName"));
eaVO.setPosition(request.getParameter("position"));
eaVO.setDeptName(request.getParameter("deptName"));
eaVO.setEmail(request.getParameter("email"));
eaVO.setHiredate(request.getParameter("hiredate"));
System.out.println(eaVO.getPosition());
EmpDAO eDao = EmpDAO.getInstance();
String msg = "";
try{
	int cnt = eDao.updateUser(eaVO);
	if(cnt == 1){
		msg = "사원 정보 수정 성공하였습니다.";
	}
}catch(NullPointerException e){
	e.printStackTrace();
	msg="사원 정보 수정 실패하였습니다.";
}catch(SQLException e){
	e.printStackTrace();
	msg="문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
}
System.out.println(msg);
%>
alert("<%=msg%>");
window.opener.location.reload();
window.close();
</script>
