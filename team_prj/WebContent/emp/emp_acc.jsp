<%@page import="com.secondproject.emp.vo.EmpSelectVO"%>
<%@page import="com.secondproject.emp.vo.EmpAddVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.emp.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="사원 대기 요청"
	isELIgnored="false"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리</title>
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
	margin-top: 150px; 
}

#title{
	margin-top: 200px;
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
	margin-top: 40px;
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

#btnAdd {
	border: 1px solid #6799FF; 
	outline:none;
	color: #6799FF; 
	border-top-right-radius: 5px; 
	border-top-left-radius: 5px; 
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	background-color: rgba(0,0,0,0); 
	padding: 5px; 
}

#btnAdd:hover {
	color:white; 
	background-color: #6799FF;
} 
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
$(function() {
	$("#btnAdd").click(function() {
		var count = 0;
		for(var i=0;i<$("[name=radio]").length;i++){
			
			if($("[name=radio]")[i].checked == true){
				var tempTd = $("#tab tr").eq(i+1).children();
				var name = tempTd.eq(1).text();
				var position = tempTd.eq(2).text();
				var deptName = tempTd.eq(3).text();
				var email = tempTd.eq(4).text();
				var hiredate = tempTd.eq(5).text();
				var height = '300';
				var width = '500';
				var left = Math.ceil((window.screen.width-width)/2); 
				var top = Math.ceil((window.screen.height-height)/2); 
				window.open("emp_modi_frm.jsp?empName="+name+"&position="+position+
						"&deptName="+deptName+"&email="+email+"&hiredate="+hiredate,"up",
						"width="+width+",height="+height+",left="+left+",top="+top);
			}
		}
	});//click add
});//ready
</script>
</head>
<body>
	<div id="wrapper">
		<div id="header">
				
			<jsp:include page="../common/jsp/menu.jsp"/>
			
			<div id="title">
				<h3 style="font-weight: bold">대기 요청</h3>
			</div>
		</div>
		
		<div id="container">
			<div class="table-responsive">
			
				<div id="btn-group" align="right">
					<input type="button" class="btn" id="btnAdd" value="사원정보 추가"/>
				</div>
				
				<form name="frm" id="frm">
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
	 						EmpDAO eDAO = EmpDAO.getInstance();
	 						List<EmpSelectVO> list = eDAO.selectedWaitingUser();
	 						for(int i=0;i<list.size();i++){
	 					%>
						<tr class='header-sub'id='row'><td><input type="radio" name='radio'/></td>
						<td><%=list.get(i).getEmp_name() %></td>
						<td><%=list.get(i).getPosition() %></td>
						<td><%=list.get(i).getDept_name() %></td>
						<td><%=list.get(i).getEmail() %></td>
						<td><%=list.get(i).getHiredate() %></td>
	 					<%		
	 						}
	 					%>
						</tr>
					</table>
				</form>
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

