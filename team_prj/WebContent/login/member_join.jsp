<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="../common/css/login.css">

<style type="text/css">
html {
  height: 100%;
}

body {
  margin:0;
  padding:0;
  font-family: sans-serif;
  background: #599fd9;
  background: -webkit-linear-gradient(to right, #599fd9, #c2e59c);
  background: linear-gradient(to right, #599fd9, #c2e59c);
}

#manager {
	margin-left: 40px;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	/* 회원가입 확인 버튼이 눌렸을 때  */
	$("#conFirm").click(function(){
		/* 유효성 검사  */
		var empName=$('input[name=empName]').val();
		var password=$('input[name=password]').val();
		var passConfirm=$('input[name=passConfirm]').val();
		var email=$('input[name=email]').val();
		var flag=false;
		
		if(empName.trim() == "" || empName == null){
			alert("사원명을 작성해주세요");
			$('input[name=empName]').focus();
			return;
		}else if(password.trim() == "" || password == null){
			alert("비밀번호를 작성해주세요");
			$('input[name=password]').focus();
			return;
		}else if(passConfirm.trim() == "" || passConfirm == null || password.trim() != passConfirm.trim()){
			alert("비밀번호를 확인해주세요");
			$('input[name=passConfirm]').val("");
			$('input[name=passConfirm]').focus();
			return;
		}else if(email.trim() == "" || email == null){
			alert("이메일을 작성해주세요");
			$('input[name=email]').focus();
			return;
		}else{
			flag=true; //빈칸 & 비밀번호 체크 완료
		}//end else
		
		/* 이메일의 형식이 올바른지 확인  */	
		     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		     if(!reg_email.test(email)) {                            
	          	alert("올바른 이메일이 아닙니다. 다시 확인해주세요.");      
	          	$('input[name=email]').focus();
				return;
			 }//end if  

		/* 이메일이 같은 것이 있는지 확인  */
		if(flag){
			$("#deptModiFrm").submit();
		}//end if 
		
		
	});//click 
	
	/* 회원가입 취소 버튼이 눌렸을 때  */
	$("#cancel").click(function(){
		location.href="member_login.jsp";
	});//click 
	
	
});//ready	


</script>

</head>
<body>
	
	<div class="login-box">
		<h2>회원가입</h2>
		<form action="member_join_insert.jsp" id="deptModiFrm" method="post">
			<div class="user-box">
				<input type="text" name="empName" id="name" > <label>사원명</label>
			</div>
			<div class="user-box">
				<input type="password" name="password" id="pass"> <label>비밀번호</label>
			</div>
			<div class="user-box">
				<input type="password" name="passConfirm" id="passConfirm" > <label>비밀번호 확인</label>
			</div>
			<div class="user-box">
				<input type="text" name="email" id="email"> <label>이메일</label>
			</div>
			<a href="#void" id="conFirm"> <span></span> <span></span> <span></span> <span></span>
				확인
			</a>
			<a href="member_login.jsp" id="cancel"> <span></span> <span></span> <span></span> <span></span>
				취소
			</a>
		</form>
	</div>
</body>
</html>

    