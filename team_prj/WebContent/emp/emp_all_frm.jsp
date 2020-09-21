<%@page import="com.secondproject.emp.vo.DeptVO"%>
<%@page import="com.secondproject.emp.vo.PositionVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.emp.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사원 정보 입력"
    isELIgnored="false"
    %>
<%
String empName = request.getParameter("empName");
String position = request.getParameter("position");
String deptName = request.getParameter("deptName");
String email = request.getParameter("email");
String hiredate = request.getParameter("hiredate");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../common/css/main.css">
    <title>사원정보 수정</title>
    <style type="text/css">
.btn {
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

.btn:hover {
	color:white; 
	background-color: #6799FF;
} 
#addFrm{margin: 0px auto;margin-top: 50px}
    </style>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function() {
        	$("#btnAcc").click(function(){
        		$("#empFrm").attr("action", "emp_all_add.jsp");
			 	if(confirm("${param.empName}님을 추가 하시겠습니까?")){
					$("#empFrm").submit();
			 	}
			});
        	$("#btnClose").click(function(){
				self.close();	
        	});
        }); //ready
    </script>
</head>
<body>
<div id="addFrm">
<div id="wrap"align="center"style="margin-top: 30px;">
<form action=""id="empFrm"name="empFrm">
        <div id="container" align="center">
        <ul>
        <li>
        <label style="margin-right:10px">사원명</label>
        <input type="text"value="<%=empName%>"class="inputBox"id="empName"name="empName"style="size: 80px;"/>
        </li>
        <li>
        <label style="margin-right:25px">직급</label>
        <%-- <input type="text"value="<%=position%>"class="inputBox"id="position"name="position"style="size: 80px;"/> --%>
        <select id="position"name="position"style="size: 80px;">
        <option>---------  선택  ---------</option>
        <%
        EmpDAO eDAO = EmpDAO.getInstance();
        List<PositionVO> list = eDAO.positionList();
        for(int i=1;i < list.size(); i++){
        %>
        <option<%=list.get(i).getPosition().equals(position)?" selected='selected'":"" %>><%=list.get(i).getPosition() %></option>
        <%	
        }
        %>
        </select>
        </li>
        <li>
        <label style="margin-right:25px">부서</label>
        <select id="detpName"name="deptName"style="size:80px">
        <option>---------  선택  ---------</option>        
		<%
		List<DeptVO> deptList = eDAO.deptList();
		for(int i=0; i < deptList.size();i++){
		%>
		<option<%=deptList.get(i).getDept_name().equals(deptName)?" selected='selected'":"" %>><%=deptList.get(i).getDept_name() %></option>
		<%
		}
		%>
		</select>
        </li>
        <li>
        <label style="margin-right:10px">이메일</label>
        <input type="text"value="<%=email%>"class="inputBox"id="email"name="email"style="size: 80px;"/>
        </li>
        <li>
        <label style="margin-right:10px">입사일</label>
        <input type="text"value="<%=hiredate%>"class="inputBox"id="hiredate"name="hiredate"style="size: 80px;"/>
        </li>
        </ul>
        </div>
</form>
			<div id="btn-group" align="center">
					<input type="button" class="btn btn-info" id="btnAcc" value="정보수정"/>
					<!-- <input type="button" class="btn btn-warning" id="btnDrop" value="탈퇴" /> -->
					<input type="button" class="btn btn-secondary" id="btnClose" value="닫기" />
				</div>
        </div>
</div>
</body>

</html>