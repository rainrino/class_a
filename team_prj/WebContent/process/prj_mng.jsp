<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="프로젝트 추가 : 프로젝트 리스트를 조회하는 페이지"
	%>
<!------------------------------2020-08-12 : DBCP에서 JNDI로 변경, checkbox를 radio로 변경---------------------------------->
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
<title>프로젝트추가</title>
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


#prjectAdd, #projectModi, #projectModiSave, #projectDelete {
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

#prjectAdd:hover, #projectModi:hover, #projectModiSave:hover, #projectDelete:hover {
	color:white; 
	background-color: #6799FF;
}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!-- DatePicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- DatePicker -->
<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#startdate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 //maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                 //onClose: function( selectedDate ) {    
                      //시작일(startDate) datepicker가 닫힐때
                      //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                   //  $("#enddate").datepicker( "option", "minDate", selectedDate );
                 //}    
 
            });
            $( "#enddate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 //maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                 //onClose: function( selectedDate ) {    
                     // 종료일(endDate) datepicker가 닫힐때
                     // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                   //  $("#startdate").datepicker( "option", "maxDate", selectedDate );
                 //}    
 
            });    
    });
</script>

<script type="text/javascript">
$(function(){
	
	/* 추가하기 버튼을 눌렀을 때 : 프로젝트 추가 페이지(prj_insert.jsp)로 이동 */
	$("#prjectAdd").click(function(){
		/* 유효성 검사  */
		var prjName=$('input[name=prjName]').val();
		var startdate=$('input[name=startdate]').val();
		var enddate=$('input[name=enddate]').val();
		var prjMng=$('select[name=prjMng]').val();

	
		if(prjName.trim() == "" || prjName == null){
			alert("프로젝트명을 작성해주세요");
			$('input[name=prjName]').focus();
			return;
		}else if(startdate.trim() == "" || startdate == null){
			alert("시작일을 작성해주세요");
			$('input[name=startdate]').focus();
			return;
		}else if(enddate.trim() == "" || enddate == null){
			alert("마감일을 작성해주세요");
			$('input[name=enddate]').focus();
			return;
		}else if(prjMng.trim() == "" || prjMng == null){
			alert("담당자를 작성해주세요");
			$('select[name=prjMng]').focus();
			return;
		}else{
			location.href="prj_insert.jsp?prjName="+prjName+"&startdate="+startdate+"&enddate="+enddate+"&prjMng="+prjMng;
		}//end else
		
	});//click
	
	/* 수정하기 버튼을 눌렀을 때 : 프로젝트 수정 페이지(prj_mng_modi.jsp)로 이동 */
	var data="";
	$("#projectModi").click(function(){
	    $('input:radio[name=prjCode]').each(function() {
	       if($(this).is(':checked')){
	       	data = $(this).val();
	       }//end if 
	       
	    });
	    
	    /* 사용자가 수정할 프로젝트를 선택했는지 여부 체크 */
	    if(data != ""){
			location.href="prj_mng.jsp?prjCode="+data;
	    }else{
	    	alert("수정할 프로젝트를 선택해주세요.");
	    }//end else
	    	
	       <%-- 사용자가 수정할 프로젝트의 정보를 가져와서 보여주기 --%>
			<%
			String prjCode=request.getParameter("prjCode");
			ProjectDAO pDao=ProjectDAO.getInstance();
			ProjectVO pVO=pDao.selectModi(prjCode);
			%>		
			
	});//click
	
			/* 수정저장 버튼을 눌렀을 때 : 프로젝트 수정 method실행 페이지(prj_modi.jsp)로 이동  */
			$("#projectModiSave").click(function(){
				var prjCode="<%=prjCode%>";
				<% if( prjCode != null) { %>
					/* 유효성 검사  */
					
					var prjName=$('input[name=prjName]').val();
					var startdate=$('input[name=startdate]').val();
					var enddate=$('input[name=enddate]').val();
					var prjMng=$('select[name=prjMng]').val();
					
					if($.trim(prjName) == "" || prjName == null || prjName == "null"){
						alert("프로젝트명을 작성해주세요");
						$('input[name=prjName]').focus();
						return;
					}else if($.trim(startdate) == "" || startdate == null || startdate == "null"){
						alert("시작일을 작성해주세요");
						$('input[name=startdate]').focus();
						return;
					}else if($.trim(enddate) == "" || enddate == null || enddate == "null"){
						alert("마감일을 작성해주세요");
						$('input[name=enddate]').focus();
						return;
					}else if($.trim(prjMng) == "" || prjMng == null || prjMng == "null"){
						alert("담당자를 작성해주세요");
						$('input[name=prjMng]').focus();
						return;
					}else{
						location.href="prj_modi.jsp?prjCode="+prjCode+"&prjName="+prjName+"&startdate="+startdate+"&enddate="+enddate+"&prjMng="+prjMng;
					}//end else
				<%}//end if%>
			});//click
	
			
	/* 삭제하기 버튼을 눌렀을 때 : 프로젝트 삭제 페이지(prj_del.jsp)로 이동 */
	$("#projectDelete").click(function(){
		$('input:radio[name=prjCode]').each(function() {
	         if($(this).is(':checked'))
	        	 data = $(this).val();
	      });
		
		/* 사용자가 삭제할 프로젝트를 선택했는지 여부 체크 */
	    if( data != "" ){
			/* 삭제하기 전 확인창 */
	    	if(confirm("선택한 프로젝트를 삭제하시겠습니까?")){
	    		location.href="prj_del.jsp?prjCode="+data;
	    	}else{
	    		alert("프로젝트 삭제를 취소했습니다.");
	    	}//end else
	    }else{
	    	alert("삭제할 프로젝트를 선택해주세요.");
	    }//end else
		
	});//click
	
});//ready	
</script>
</head>
<body>
	<div id="wrapper">

		<div id="header">
			<jsp:include page="../common/jsp/menu.jsp"></jsp:include>			
			<div id="title">
				<h3 style="font-weight: bold">프로젝트추가</h3>
			</div>
		</div>
 			<!--------------------- 추가하기, 수정하기, 수정저장, 삭제 버튼 --------------------------->
		<div id="prjContainer">
			<div class="table-responsive">
			
				<div id="prjBtnDiv" align="right"> 
					<button type="button" id="prjectAdd" class="btn">추가하기</button>
					<button type="button" id="projectModi" class="btn">수정하기 </button>
					<button type="button" id="projectModiSave" class="btn">수정 저장</button>
					<button type="button" id="projectDelete" class="btn">삭제</button>
				</div>

				<form action="prj_mng_modi.jsp" id="prjFrm" method="get">
					<table class="myTable">
						<tr class="header">
							<th>선택</th>
							<th>프로젝트명</th>
							<th>시작일</th>
							<th>마감일</th>
							<th>담당자</th>
						</tr>
						<tbody>
						<%
						/* 수정하기를 누른 상태가 아니라면, text창에 null를 표시하지 않기  */
						String prjName = (pVO.getPrjName() != null ? pVO.getPrjName() : "");
						String startdate = (pVO.getStartdate() != null ? pVO.getStartdate() : "");
						String enddate = (pVO.getEnddate() != null ? pVO.getEnddate() : "");
						String prjMng = (pVO.getPrjMng() != null ? pVO.getPrjMng() : "");
						%>
						<!-- 2020-08-21 수정 프로젝트 매니저 리스트 추가  -->
						
						<tr class="header-sub" >
							<td></td>
							<td><input type="text" id="prjName"  name="prjName"  value="<%= prjName %>" ></td>
							<td><input type="text" id="startdate" name="startdate"  value="<%= startdate %>" placeholder="yyyyMMdd" style="text-align:center" readonly></td>
							<td><input type="text" id="enddate" name="enddate" value="<%= enddate %>"  placeholder="yyyyMMdd" style="text-align:center" readonly></td>
							<td>
								<select id="prjMng" name="prjMng" >
									<% 
									//모든 부서 사원 출력하기 (관리자)
									//ProjectDAO pDao=ProjectDAO.getInstance();
									List<String> listPrjMngList=new ArrayList<String>();
									listPrjMngList=pDao.selectPrjMng();
									if(listPrjMngList.size() != 0){
										for(int i=0; i < listPrjMngList.size(); i++) { %>
										<option value="<%= listPrjMngList.get(i) %>"><%=listPrjMngList.get(i)  %></option>
									<% }//end for 
										}else{%>
										<option>사원없음</option>
										<% 
										}//end if 
										%>
								</select>
							</td>
						</tr>

						<% 
						//Project Table 내용을 출력하기 (관리자)
						//ProjectDAO pDao=ProjectDAO.getInstance();
						List<ProjectMngVO> listPrjMng=new ArrayList<ProjectMngVO>();
						listPrjMng=pDao.selectAllProjectMng();
						
						if(listPrjMng.size() != 0){
							for(ProjectMngVO pmVO : listPrjMng ) { %>
							<tr>
								<td><input type="radio" name="prjCode" value="<%= pmVO.getPrjCode() %>" /></td>
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

