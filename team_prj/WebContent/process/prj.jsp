<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>프로젝트현황</title>
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

#prjContainer {
	position: relative;
	width: 1300px;
	min-height: 550px;
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


/* 테이블 디자인  */
.table-responsive{
	align-content: center;
	width: 100px; 
	margin-top: 50px;
	margin-right: 100px;
}

.myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 15px;
	text-align: center;
	margin-top: 80px;
}

.myTable th, .myTable td {
	text-align: center;
	padding: 12px;
}

.myTable tr {
	border-bottom: 1px solid #ddd;
}

.myTable tr.header{
	background-color: #84D9CF; 
}
tbody tr:hover,.header-sub:hover {
	background-color: #F6F6F6;
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="styles/index.processed.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
});//ready	
</script>
</head>
<body>
	<div id="wrapper">

		<div id="header">
		<jsp:include page="../common/jsp/menu.jsp"/>
			<div id="title">
				<h3 style="font-weight: bold">프로젝트현황</h3>
			</div>
		
		</div>

		<div id="prjContainer">
			<div id="prjTableDiv">
				<table class="myTable">
					<tr class="header">
						<th>프로젝트명</th>
						<th>시작일</th>
						<th>마감일</th>
						<th>담당자</th>
					</tr>
					<tbody>
					
					<% 
					//Project Table 내용을 출력하기 (관리자)
					ProjectDAO pDao=ProjectDAO.getInstance();
					List<ProjectVO> listPrj=new ArrayList<ProjectVO>();
					listPrj=pDao.selectAllProject();
					
					if(listPrj.size() != 0){
						for(ProjectVO pmVO : listPrj ) { %>
						<tr class="header-sub">
							<td><!-- <a href="#void"> --><%= pmVO.getPrjName() %></a></td>
							<td><%= pmVO.getStartdate() %></td>
							<td><%= pmVO.getEnddate() %></td>
							<td><%= pmVO.getPrjMng() %></td>
						</tr>
						<% }//end for 
						}else{%>
						<tr>
							<td colspan="5">조회된 프로젝트가 없습니다.</td>
						</tr>
					<% 
					}//end if 
					%>
					</tbody>
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

