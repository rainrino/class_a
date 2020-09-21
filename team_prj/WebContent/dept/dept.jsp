<%@page import="com.secondproject.dept.vo.DeptVO"%>
<%@page import="com.secondproject.dept.dao.DeptDAO"%>
<%@page import="com.secondproject.dept.vo.EmpDeptVO"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="부서관리 : 부서관리 리스트를 조회하는 페이지"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
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
<title>부서관리</title>
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

#deptContainer {
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
	height: 300px; 
	margin-top: 50px;
	margin-right: 100px;
}

.myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 15px;
	text-align: center;
	/* margin-top: 80px; */
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

#deptAdd, #deptModi, #deptDelete {
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

#deptAdd:hover, #deptModi:hover, #deptDelete:hover {
	color:white; 
	background-color: #6799FF;
}

/*********************************** 버튼 클릭시 나타나는 창 (일괄 적용)  *************************************************************/
#deptAddDiv{ width: 25%; height: 50%; margin: 0px auto; position:absolute; left:38%; top:-30%; background-color: #E2E2E2;  opacity: 90%}
.deptBtnDiv{margin-left: 27%;}

/*********************************** 부서 추가 창  *************************************************************/
#deptInsertH3{ margin-top: 8%;  margin-left: 2%;}
#deptInsertDeptName{ margin-top: 5%; margin-left: 2%; margin-bottom: 28% ;height: 15%; width: 92%;}
#deptInsertBtn{ width: 30%;}
#deptInsertCancel{ width: 30%;}

/*********************************** 부서 수정 창  *************************************************************/
#deptModiH3{ margin-top: 8%;  margin-left: 2%; margin-bottom: 5%}
#deptModiSelect{width: 95%; height: 15%; margin-right: 100%; margin-left: 2% }
#deptModiDeptName{width: 95%; height: 15%; margin-bottom: 10%; margin-left: 2% }
#deptModiBtn{ width: 30%;}
#deptModiCancel{ width: 30%;}

/*********************************** 부서 삭제 창  *************************************************************/
#deptDelH3{ margin-top: 8%;  margin-left: 2%; margin-bottom: 5%}
#deptDelSelect{width: 95%; height: 15%; margin-right: 100%; margin-left: 2%; margin-bottom: 25% }
#deptDelBtn{ width: 30%;} 
#deptDelCancel{ width: 30%;}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	
	/* 부서 select가 변경되었을 때 :   */
	$("#deptSelect").change(function(){
		var deptNo=$("#deptSelect").find(":selected").val();
		if(deptNo != "all"){
			location.href="dept.jsp?deptNo="+deptNo;
		}else{
			location.href="dept.jsp";
		}
	});//onchange

	/* 부서추가하기 버튼을 눌렀을 때 : 부서 추가 페이지(dept_insert.jsp)생성 */
	$("#deptAdd").click(function(){
		
		location.href="dept.jsp?page_flag=dept_insert_frm";
		
	});//click
	
	/* 부서추가 창에서 부서명을 입력한뒤 확인 버튼을 눌렀을 시 */
	$("#deptInsertBtn").click(function(){
		var deptName=$('input[name=deptInsertDeptName]').val();
		if(deptName.trim() == "" || deptName == null){
			alert("생성할 부서명을 작성해주세요");
			$('input[name=deptInsertDeptName]').focus();
			return;
		}else{
			location.href="dept_insert.jsp?deptName="+deptName;
		}//end else
	});//click

	
	/* 부서수정하기 버튼을 눌렀을 때 : 부서 수정 페이지(dept_modi_frm.jsp)생성 */
	$("#deptModi").click(function(){
		
		location.href="dept.jsp?page_flag=dept_modi_frm";
		
	});//click
	
	/* 부서수정 창에서 확인 버튼을 눌렀을 때 : 부서명 수정 페이지(dept_modi.jsp)로 이동  */
	   $("#deptModiBtn").click(function(){
	      var deptNo=$("#deptModiSelect").find(":selected").val();
	      var deptNewName=$("#deptModiDeptName").val();
	      if(deptNo == "all"){
	         alert("변경할 부서를 선택해주세요.");
	      }else if(deptNo == "empty"){
	         alert("생성된 부서가 없습니다. 부서를 생성한 뒤에 시도해주세요.");
	      }else if(deptNewName.trim() == "" || deptNewName == null ){
	         alert("변경할 부서명을 작성해주세요.");
	      }else{
	         $("#deptModiFrm").submit();
	      }//end else
	      
	   });//click
	
	/* 부서삭제하기 버튼을 눌렀을 때 : 부서 삭제 페이지(dept_modi_frm.jsp)생성 */
	$("#deptDelete").click(function(){
		
		location.href="dept.jsp?page_flag=dept_del_frm";
		
	});//click
	
	/* 부서삭제 창에서 확인 버튼을 눌렀을 때 : 부서명 삭제 페이지(dept_del.jsp)로 이동  */
	$("#deptDelBtn").click(function(){
		var deptNo=$("#deptDelSelect").find(":selected").val();
		if(deptNo == "all"){
			alert("삭제할 부서를 선택해주세요.");
		}else if(deptNo == "empty"){
			alert("생성된 부서가 없습니다. 부서를 생성한 뒤에 시도해주세요.");
		}else{
			/* 삭제하기 전 확인창 */
	    	if(confirm("선택한 부서를 삭제하시겠습니까?")){
				$("#deptDelFrm").submit();
	    	}else{
	    		alert("부서 삭제를 취소했습니다.");
	    	}//end else
		}//end else
		
	});//click
	
	/* deptNo 가져오기 */
	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}

	var searchValue=getParameterByName("deptNo");
	/* selected 부여 */
		var searchArr = $('#deptSelect').find("option");  
		 searchArr.each(function(i){      
		  var optionValue = $(this).val();     
		  if(optionValue == searchValue){            
		   $(this).attr("selected","selected"); 
		  }
		 });
	
});//ready

/* 부서추가/부서수정/부서삭제 창에서 취소 버튼을 눌렀을 때  */
function cancelBtn(){
	location.replace("dept.jsp");
}//cancelBtn

</script>
</head>
<body>
	<div id="wrapper">

		<div id="header">
			
			<jsp:include page="../common/jsp/menu.jsp"/>
						
			<div id="title">
				<h3 style="font-weight: bold">부서관리</h3>
			</div>
		</div>
 			<!--------------------- 추가하기, 수정하기, 삭제 버튼 --------------------------->
		<div id="deptContainer">
		<!---------------------------------부서 선택 select창 --------------------------------------->
			<div id="deptSelectDiv">
				<select style="width: 100px; height:30px" id="deptSelect">
				<% 
					//모든 부서 출력하기 (관리자)
					DeptDAO dDao=DeptDAO.getInstance();
					List<DeptVO> listDept=new ArrayList<DeptVO>();
					listDept=dDao.allSelectDept();
					
					if(listDept.size() != 0){%>
					
						<option value="all">전체</option>
						<% for( DeptVO dVO : listDept ) { %> 
						<option value="<%= dVO.getDeptNo() %>" ><%= dVO.getDeptName() %></option>
						<% }//end for 
					}else{%>
						<option value="empty">부서없음</option>
					<% 
					}//end if 
					%>
				</select>
			</div>
		<c:if test="${not empty param.page_flag }">
			<div id="deptAddDiv">
			<%-- 파라메터에 따라 부서추가, 부서수정, 부서삭제 폼이 들어갈 위치 --%>
			<c:import url="${param.page_flag }.jsp"/>
			</div>
	     </c:if>
	    <%
					if(!positionArr[0].equals(position) || !positionArr[1].equals(position)){
					%>
				<div id="deptBtnDiv" align="right"> 
					<button type="button" id="deptAdd" class="btn">추가하기</button>
					<button type="button" id="deptModi" class="btn">수정하기 </button>
					<button type="button" id="deptDelete" class="btn">삭제</button>
				</div>
		<%
					}
					%>	
			<div class="table-responsive">
					<table class="myTable">
						<tr class="header">
							<th>사원</th>
						</tr>
						<tbody>
						<%
					//부서에 소속된 사원 조회하기 
					String deptNo=request.getParameter("deptNo"); 
					
					List<EmpDeptVO> listEmpDept=new ArrayList<EmpDeptVO>();
					
					if(deptNo == null){ //사용자가 부서 선택 창을 누르지 않은 상태 : 전체 사원을 조회한다.
						deptNo="all";
					}//end if 
					
					listEmpDept=dDao.selectDeptEmp(deptNo);
					
					if(listEmpDept.size() != 0){
						for(EmpDeptVO edVO : listEmpDept){
					%>
						<tr class="header-sub">
							<td><%= edVO.getPosition() %>&nbsp;<%= edVO.getEmpName() %></td>
						</tr>
					<%}//end for
					}else{%> 
						<tr>
							<td>조회된 사원이 없습니다.</td>
						</tr>
					<% }//end else%>
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

