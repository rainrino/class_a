<%@page import="com.secondproject.process.vo.ProjectVO"%>
<%@page import="com.secondproject.process.vo.SelectProcessVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.process.dao.ProcessDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="공정관리 : 관리자가 공정관리 리스트를 조회하는 페이지"
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정관리</title>
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

#processAdd, #processModify, #processSave, #processDelete {
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

#processAdd:hover, #processModify:hover, #processSave:hover, #processDelete:hover {
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
            $( "#start_date" ).datepicker({
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
                     //$("#complete_date").datepicker( "option", "minDate", selectedDate );
                 //}    
 
            });
            $( "#complete_date" ).datepicker({
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
                     //$("#start_date").datepicker( "option", "maxDate", selectedDate );
                // }    
 
            });    
    });
</script>

<script type="text/javascript">

$(function() {
	 
	var flag = false;
	
	$("#complete_date").keydown(function(evt){
		if(evt.which == 9){
			if($("#complete_date").val() != ""){
			$("#working_days").val($("#complete_date").val() - $("#start_date").val()+1);
			}
		}
	});
	$("#working_days").click(function(){
		if($("#complete_date").val() != ""){
			$("#working_days").val($("#complete_date").val() - $("#start_date").val()+1);
			}
	});
	//공정 추가 버튼 클릭 시
	$("#processAdd").click(function() {
		
		chkNull();
		 
		if( flag == false ){
			location.href="process_insert.jsp?prj_name="+$("#prj_name").val()+"&prj_mgr="+$("#prj_mgr").val()
			+"&dept_name="+$("#dept_name").val()+"&process_name="+  $("#process_name").val()+
			"&start_date="+$("#start_date").val()
			+"&complete_date="+ $("#complete_date").val()+"&working_days="+$("#working_days").val()
			+"&note="+$("#note").val();
		}else {
			location.href="process.jsp";
		}//end else
		
	});//click

	
	var data = "";
	
	//공정 수정 버튼 클릭 시
	$("#processModify").click(function() {
		
		//$.each(배열,function(인덱스용매개변수,배열 방의 값을 저장 할 매개변수)
		$('.processCode').each(function(i,obj) {  
			if($(obj).is(':checked')){ //radio 선택됐으면
				//radio(obj) 다음(next)에 나온<span>에 넣은 값을 csv로 얻어 
				// ,로 잘라서 선택한 항목 값의 배열
				
	        	var modifyData=$(obj).next().html().split(","); 

				/* 선택 항목 값 select, input에 넣어주기(맨 윗줄)  */
				
				 $("#prj_name").val( modifyData[0] );
	        	 $("#old_prj_name").val( modifyData[0]);
	        	 $("#prj_mgr").val( modifyData[1]);
	        	 $("#dept_name").val( modifyData[2]);
	        	 $("#process_name").val( modifyData[3]);
	        	 $("#start_date").val( modifyData[4]);
	        	 $("#complete_date").val( modifyData[5]);
	        	 $("#working_days").val( modifyData[6]);
	        	 $("#note").val( modifyData[7]);
	         	
	        	 data = "radioChecked&saveBtnClicked";
		    }//end if
	    });//each
		
		if(data !="radioChecked&saveBtnClicked"){
			alert("수정항목을 선택해주세요");
		}//end if
		
	});//click

	
	//공정 수정저장 버튼 클릭 시
	$("#processSave").click(function() {
		
		if(data == "radioChecked&saveBtnClicked"){
			chkNull();

			location.href="process_saveModify.jsp?prj_name="+$("#prj_name").val()+"&old_prj_name="+$("#old_prj_name").val()+"&prj_mgr="+$("#prj_mgr").val()
			+"&dept_name="+$("#dept_name").val()+"&process_name="+  $("#process_name").val()+
			"&start_date="+$("#start_date").val()
			+"&complete_date="+ $("#complete_date").val()+"&working_days="+$("#working_days").val()
			+"&note="+$("#note").val();
		}else{
			alert("수정항목을 선택해주세요");
		}//end else
	});//click

	
	//공정 삭제 버튼 클릭 시
	$("#processDelete").click(function() {
		
  	     var obj = document.frm;
  	     
  	     if( $("input[name='processCode']").is(':checked') ){
  	    	if( confirm("선택한 프로젝트를 삭제하시겠습니까?") ){
  	    		obj.action="process_delete.jsp";
				obj.submit();
  	    		return;
  	    	}else {
  	    		alert("프로젝트 삭제를 취소했습니다.");
  	    		return;
  	    	}//end else

  	     }//end if 
  	     alert("삭제할 프로젝트를 선택해주세요."); 
		 
	});//processDelete click

});//ready


function chkNull() {
	
	if ($("#prj_name").val() == "선택" || $('#prj_mgr').val() == "선택"
		|| $("#dept_name").val() == "" || $("#process_name").val() == ""
		|| $("#start_date").val() == "" || $("#complete_date").val() == ""
		|| $("#working_days").val() == "")
		 {
		alert("누락된 항목이 없는지 확인해 주세요");
		flag = !flag;
	}//end if
 
}//chkNull

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
			
				<div id="btn-group" align="right">
					<input type="button" class="btn" id="processAdd" value="공정 추가"/>
					<input type="button" class="btn" id="processModify" value="공정 수정"/>
					<input type="button" class="btn" id="processSave" value="수정 저장"/>
					<input type="button" class="btn" id="processDelete" value="공정 삭제" />
				</div>
				
				<form name="frm" action="process_saveModify.jsp" method="get">
					<div style="overflow-y:scroll: auto" >
						<table class="myTable">
							<thead>
								<tr class="header">
									<th></th>
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
							<tr class="header-sub">
								<td ></td>
								<td>
									<select name="prj_name" id="prj_name" style="width: 130px">
										<option>선택</option>
										<%
										//프로젝트명 option에 보여주기
										ProcessDAO pDAO = ProcessDAO.getInstance();
										List<ProjectVO> listPrjName = pDAO.selectPrjName();
										for(int i=0; i< listPrjName.size() ; i++){
										%>	
											<option><%= listPrjName.get(i).getPrj_name() %></option>
										<%	}//end for %>
									</select>
									<input type="hidden" name="old_prj_name" id="old_prj_name" />
								</td>
								
								<td>
									<select name="prj_mgr" id="prj_mgr" style="width: 130px">
										<option>선택</option>
										<%
										//프로젝트 담당자 option에 보여주기
										List<String> listPrjMgr = pDAO.selectPrjMgr();
										for(int i=0; i< listPrjMgr.size() ; i++){
										%>	
											<option><%= listPrjMgr.get(i) %></option>
										<%	}//end for %>
									</select>
								</td>
	
								<td>
									<select name="dept_name" id="dept_name" style="width: 130px">
										<option>선택</option>
										<%
										//담당부서 option에 보여주기
										List<String> listDeptName = pDAO.selectDeptName();
										for(int i=0; i< listDeptName.size() ; i++){
										%>	
											<option><%= listDeptName.get(i) %></option>
										<%	}//end for %>
									</select>
								</td>

								<td><input type="text" size="13" id="process_name" name="process_name" /></td>
								<td><input type="text" size="13" id="start_date" name="start_date" placeholder="yyyymmdd" readonly/></td>
								<td><input type="text" size="13" id="complete_date" name="complete_date" placeholder="yyyymmdd" readonly /></td>
								<td><input type="text" size="4" id="working_days" name="working_days" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자" readonly/></td>
								<td><input type="text" size="13" id="note" name="note"/></td>
							</tr>
							
							<%
							ProcessDAO pDao = ProcessDAO.getInstance();
							//조회된 리스트가 들어갈 객체가 하나가 만들어진다.
							List<SelectProcessVO> listPro = pDao.selectAllProcess();
							
							//라디오버튼 클릭 시 선택한 행이 수정된다.
							for(SelectProcessVO spVO : listPro ){ %>
								<tr>
									<td><input type="radio" name="processCode" class="processCode" value="<%= spVO.getProcess_code() %>" />
										<span style="display:none"><%=spVO.getProjectName() %>,<%=spVO.getProjectMgr() %>,<%=spVO.getDeptName() %>,<%=spVO.getProcessName() %>,<%=spVO.getStart_date() %>,<%=spVO.getComplete_date() %>,<%=spVO.getWorking_days() %>,<%=spVO.getNote() %></span>
									</td>							
									
									<td><%= spVO.getProjectName() %></td>
									<td><%= spVO.getProjectMgr() %></td>
									<td><%= spVO.getDeptName() %></td>
									<td><%= spVO.getProcessName() %></td>
									<td><%= spVO.getStart_date() %></td>
									<td><%= spVO.getComplete_date() %></td>
									<td><%= spVO.getWorking_days() %></td>
									<td><%= spVO.getNote() %></td>
								</tr>
							<% }//end for %>
							
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

