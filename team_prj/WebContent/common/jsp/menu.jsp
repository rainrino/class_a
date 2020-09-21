<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공정관리 header_nav(메뉴밑에  active기능 따로 주기 위해서)"
    %>
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
//System.out.println(email+" / "+position+" / "+name);
%>
<header class="main-header">
	<div id="logo" style="width: 100px; float: left;">
		<a class="navbar-brand" href="../main/schedule.jsp"> 
			<img src="../common/images/logo.png" style="width: 50px; height: 50px; margin-left: 100px; margin-top: 20px"  /> 
		</a>
	</div>
	<div class="container">
		<nav class="navbar navbar-expand-sm bg sticky-top">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainMenu"
					aria-controls="mainMenu" aria-expanded="false"
					aria-label="Toggle navigation">
				<span class="icon-bar icon-bar-1"></span>
				<span class="icon-bar icon-bar-2"></span> 
				<span class="icon-bar icon-bar-3"></span>
			</button>

			<div class="collapse navbar-collapse" id="mainMenu" style="	margin-top: 18px">
				<ul class="navbar-nav ml-auto text-uppercase f1">
					<%
					if(positionArr[0].equals(position) || positionArr[1].equals(position)){
					%>
					<li><a href="../process/process_user.jsp"<%="process.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>공정관리</a>
					<ul id=" sub-menu">
						<li><a href="../process/prj.jsp">프로젝트보기</a></li>
						<li><a href="../process/process_user.jsp">공정보기</a></li>
					</ul>
					<%
					}else{
					%>
					<li><a href="../process/process.jsp"<%="process.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>공정관리</a>
					<ul id=" sub-menu">
						<li><a href="../process/prj_mng.jsp">프로젝트추가</a></li>
						<li><a href="../process/process.jsp">공정추가</a></li>
					</ul>
					<%
					}
					%>
					</li>
					<li><a href="../inventory/inventory.jsp"<%="inventory.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>재고관리</a></li>
					<%
					if(!"마스터".equals(position)){
					%>
					<li><a href="../emp/emp_only.jsp"<%="emp_only.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>사원관리</a>
					<ul id=" sub-menu">
						<li><a href="../emp/emp_only.jsp">전체 사원</a></li>
					</ul>
					<%
					}else{//슈퍼유저 수정 필요
					%>
					<li><a href="../emp/emp_all.jsp"<%="emp_all.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>사원관리</a>
					<ul id=" sub-menu">
						<li><a href="../emp/emp_all.jsp">사원관리</a></li>
						<li><a href="../emp/emp_acc.jsp">대기 요청</a></li>
					</ul>
					<%
					}
					%>
					</li>
					<%
					if("마스터".equals(position)){//부서관리 사용자 볼 필요 ㄴㄴ
					%>
					<li><a href="../dept/dept.jsp"<%="dept.jsp".equals(uri.substring(uri.lastIndexOf("/")+1))?" class='active active-first'":"" %>>부서관리</a></li>
					<%
					}
					%>
					<li><a  href="#void"onclick="javascript:window.location.replace('../login/member_logout.jsp')"style="margin-left: 10px;font-size: 14x;color: #FFFF66">로그 아웃</a></li>
				</ul>
			</div>
		</nav>
	</div>
</header>