<%@page import="com.secondproject.process.vo.ProjectVO"%>
<%@page import="com.secondproject.process.vo.SelectProcessVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.process.dao.ProcessDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="공정관리 : 사용자가 공정관리 리스트를 조회하는 페이지"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>공정관리 사용자 페이지</title>
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
	margin-top: 100px; 
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

tbody tr:hover, .header-sub:hover {
	background-color: #F6F6F6;
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(function() {
	
	/* 프로젝트 select가 변경되었을 때 :   */
	$("#projectSelect").change(function(){
		var prj_code = $("#projectSelect").find(":selected").val();
		//전체보기 option이 아니라면
		if(prj_code != "all"){
			location.href="process_user.jsp?prj_code="+prj_code;
		}else{
			location.href="process_user.jsp";
		}//end else
	});//onchange
	
	
	/* prj_code 가져오기 */
	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}

	var searchValue = getParameterByName("prj_code");
	
	/* selected 부여 */
	var searchArr = $('#projectSelect').find("option");
	
	searchArr.each(function(i){
		var optionValue = $(this).val();
	 	
		if(optionValue == searchValue){
	 		$(this).attr("selected","selected");
	 		
	 	}//end if
	});//each

});//ready

</script>
</head>
<body>
	<div id="wrapper">

		<div id="header">
		
			<jsp:include page="../common/jsp/menu.jsp"></jsp:include>
			
			<div id="title">
				<h3 style="font-weight: bold">공정관리</h3>
			</div>
		</div>

		<div id="container">
			<div class="table-responsive">
			
				<form name="frm">
					
					<!-- 사용자가 조회 시 프로젝트별로 보여줌 -->					
					<div align="right">
						<select id="projectSelect" name="projectSelect"style="width: 130px">
						<%
						ProcessDAO pDao = ProcessDAO.getInstance();
						
						List<ProjectVO> listPrjName = new ArrayList<ProjectVO>();
						listPrjName = pDao.selectPrjName();
						
						if(listPrjName.size() != 0){%>
						
							<option value="all">전체보기</option>
							<% for( ProjectVO pVO : listPrjName) { %> 
							<option value="<%= pVO.getPrj_code() %>" ><%= pVO.getPrj_name() %></option>
							<% }//end for 
						}else{%>
							<option value="empty">프로젝트 없음</option>
						<% 
						}//end if 
						%>
					</select>
					</div>
					
					<div style="overflow-y:scroll: auto" >
						<table class="myTable">
							<thead>
								<tr class="header">
									<th>프로젝트명</th>
									<th>프로젝트 담당자</th>
									<th>담당부서</th>
									<th>공정명</th>
									<th>시작일</th>
									<th>완료일</th>
									<th>작업일수</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody> 
							<%
							String prj_code = request.getParameter("prj_code"); 
							
							List<SelectProcessVO> listAllProcess = new ArrayList<SelectProcessVO>();
							
							if(prj_code == null){ 
								prj_code="all";
							}//end if 
							
							listAllProcess = pDao.selectAllPrjName(prj_code);

							if(listAllProcess.size() != 0){
								for(SelectProcessVO spVO : listAllProcess){
							%>
								<tr class="header-sub">
									<td><%= spVO.getProjectName() %></td>
									<td><%= spVO.getProjectMgr() %></td>
									<td><%= spVO.getDeptName() %></td>
									<td><%= spVO.getProcessName() %></td>
									<td><%= spVO.getStart_date() %></td>
									<td><%= spVO.getComplete_date() %></td>
									<td><%= spVO.getWorking_days() %></td>
									<td><%= spVO.getNote() %></td>
								</tr>
							<%}//end for
							}else{%> 
								<tr>
									<td>조회된 프로젝트가 없습니다.</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							<% }//end else%>
							
							</tbody>
						</table>
					</div>
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

