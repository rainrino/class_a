<%@page import="com.secondproject.emp.vo.DeptVO"%>
<%@page import="com.secondproject.emp.vo.EmpOnlyVO"%>
<%@page import="com.secondproject.emp.vo.EmpSelectVO"%>
<%@page import="com.secondproject.emp.vo.EmpAddVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.emp.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="사원 관리 메인"
	isELIgnored="false"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");

String email = (String) session.getAttribute("user_email");
String position = (String) session.getAttribute("user_position");
String name = (String) session.getAttribute("user_name");
String uri = request.getRequestURI();
if(email == null){
	response.sendRedirect("../login/member_login.jsp");
	return;
}

String superuser = "마스터";
String[] positionArr = {"대리","사원"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 사원</title>
<link rel="stylesheet" type="text/css" href="../common/css/header.css">
<style type="text/css">
#wrap {
	width: 1300px;
	height: 930px;
	margin: 0px auto;
}

#header {
	width: 1300px;
}

#container {
	position: relative;
	width: 1300px;
	min-height: 600px;
	position: relative;
	margin: 0px auto;
	margin-top: 80px;
}

#footer {
	width: 100%;
	padding: 20px;
	position: relative;
	text-align: center;
	height: 100px;
	background-color: #F6F6F6;
	margin-top: 50px; 
}

#title{
	margin-top:  200px;
	margin-left: 310px;
}

/* sub-menu  */
ul { display:block; padding:0px;}
ul li{ display: inline-block; position:relative;}
ul li ul { display:none; position:absolute; top:100%; left:0;}
ul li ul li { display:block;}
ul li ul li ul { left:100%; top:0;}
ul li:hover > ul { display:block; width:120px;}

.table-responsive{
	align-content: center;
	margin-top: 50px;
	margin-right: 100px;
}

.myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 15px;
	text-align: center;
	margin-top: 60px;
}

.myTable th, .myTable td {
	text-align: left;
	padding: 12px;
}

.myTable tr {
	border-bottom: 1px solid #ddd;
}

.myTable tr.header{
	background-color: #84D9CF;
}
.header-sub:hover {
	background-color: #F6F6F6;
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
$(function() {
	
	$("#dept_name").change(function(){
	
		$("#deptFrm").submit();
	
	});//change
});//ready

</script>
</head>
<body>
	<div id="wrapper">
		<div id="header">
		
			<jsp:include page="../common/jsp/menu.jsp"/>
			
			<div id="title">
				<h3 style="font-weight: bold">전체 사원</h3>
			</div>
		</div>
		
		<div id="container">
			<div class="table-responsive">
				<form action=""id="deptFrm">
					<div align="right">
						<select id="dept_name"name="dept_name"style="width: 100px">
						<option>전체보기</option>
						<%
						String dept_name = request.getParameter("dept_name");
						EmpDAO eDAO = EmpDAO.getInstance();
						List<DeptVO> deptList = eDAO.deptList();
						for(int i=0; i < deptList.size();i++){
						%>
						<option<%=deptList.get(i).getDept_name().equals(dept_name)?" selected='selected'":"" 
						%>><%=deptList.get(i).getDept_name() %></option>
						<%
						}
						%>
						</select>
					</div>
				</form>
	
				<table class="myTable"id="tab">
					<tr class="header">
						<th></th>
						<th>사원명</th>
						<th>직급</th>
						<th>부서</th>
						<th>이메일주소</th>
						<th>입사일</th>
					</tr>
					<%
				 	DeptVO deVO = new DeptVO();
					deVO.setDept_name(dept_name);
					List<EmpOnlyVO> empList = eDAO.selectOnlyEMP(deVO);
					for(int i=0;i<empList.size();i++){
					%>
					<tr class='header-sub'id='row'>
						<td></td>
						<td><%=empList.get(i).getEmp_name() %></td>
						<td><%=empList.get(i).getPosition() %></td>
						<td><%=empList.get(i).getDept_name() %></td>
						<td><%=empList.get(i).getEmail() %></td>
						<td><%=empList.get(i).getHiredate() %></td>
					</tr>
					<%	}//end for %>
				</table>
			</div>
		</div>

		<div id="footer">
			<p>
				With supporting text below as a natural lead-in to additional
				content.<br /> &copy; CopyRight. All Right Reserved. Class A
			</p>
		</div>
		
	</div>
</body>
</html>

