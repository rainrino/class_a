<%@page import="com.secondproject.login.vo.PositionVO"%>
<%@page import="com.secondproject.login.vo.LoginVO"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="com.secondproject.login.dao.LoginDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="로그인 페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="../common/css/login.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<style type="text/css">
html {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	font-family: sans-serif;
	background: #599fd9;
	background: -webkit-linear-gradient(to right, #599fd9, #c2e59c);
	background: linear-gradient(to right, #599fd9, #c2e59c);
}

#manager {
	margin-left: 40px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#emil").keydown(function(evt) {
			chkNull(evt);
		});
		$("#pass").keydown(function(evt) {
			chkNull(evt);

		});
	});//ready

	function chkNull(evt) {
		if (evt.which == 13 || evt.which == 9) {
			if ($("#email").val() == "") {
				alert("이메일 필수 입력");
				$("#email").focus();
				return;
			}
		}//end if
		if (evt.which == 13 || evt.which == 9) {
			if ($("#pass").val() == "") {
				alert("비밀번호 필수 입력");
				$("#pass").focus();
				return;
			}
			$("#loginFrm").submit();
		}//end if
	}//chkPass

</script>
</head>
<body>

	<%
	LoginVO lVO = new LoginVO();
	PositionVO poVO = new PositionVO();
	lVO.setEmail(request.getParameter("email"));
	String name = "";
	if (lVO.getEmail() != null) {
		session.setAttribute("user_email", lVO.getEmail());
		lVO.setPassword(DataEncrypt.messageDigest("MD5", request.getParameter("pass")));
		LoginDAO l_DAO = LoginDAO.getInstance();
		poVO.setPosition(l_DAO.selectPosition(lVO.getEmail().trim()));
		if (poVO.getPosition() != null) {
			session.setAttribute("user_position", poVO.getPosition());
				name = l_DAO.selectName(lVO);
			if (!"".equals(name)) {
				session.setAttribute("user_name", name);
	%>
	<script type="text/javascript">
	window.location.replace("../main/schedule.jsp");
	</script>
	<%
		}else{
			%>
			<script type="text/javascript">
				alert("아이디와 비밀번호를 다시 입력해주세요.");
				$("#email").focus();
				location.href = "member_login.jsp";
			</script>
			<%
		}
	%>
	<%-- <jsp:forward page="../process/process.jsp" /> --%>
	<script type="text/javascript">
	location.replace("../main/schedule.jsp");
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("관리자가 승인하지 않았습니다. 조금 더 기다려 주세요.");
		location.href = "member_login.jsp";
	</script>
	<%
		}
	} else {
	%>
	<div class="login-box">
		<h2>로그인</h2>
		<form name="loginFrm" action="member_login.jsp" id="loginFrm"
			method="post">
			<div class="user-box">
				<input type="text" name="email" id="email" class="inputBox"
					required="required" autofocus="autofocus"> <label>이메일</label>
			</div>
			<div class="user-box">
				<input type="password" name="pass" id="pass" class="inputBox"
					required="required"> <label>비밀번호</label>
			</div>
			<a id="loginBtn" href="javascript:document.loginFrm.submit();"> <span></span>
				<span></span> <span></span> <span></span> 로그인
			</a> <a href="member_join.jsp"> <span></span> <span></span> <span></span>
				<span></span> 회원가입
			</a>
		</form>
	</div>
	<%
		}
	%>
</body>
</html>

