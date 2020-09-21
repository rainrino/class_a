<%@page import="com.secondproject.inventory.vo.InventoryEmpVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.inventory.dao.InventoryDAO"%>
<%@page import="com.secondproject.inventory.vo.InventoryVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
<html lang="en">

<head>
<meta charset="UTF-8" />
<title>재고관리</title>
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
	width: 1200px;
	border: 1px solid #ddd;
	font-size: 15px;
	text-align: center;
}

.class {
	border: 1px solid #333;
}

.myTable th {
	text-align: center;
	padding: 12px;
}
.myTable td {
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

<!-- DatePicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- DatePicker -->
<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#orderDate" ).datepicker({
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
                     //$("#inDate").datepicker( "option", "minDate", selectedDate );
                 //}    
 
            });
            $( "#inDate" ).datepicker({
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
                     //$("#orderDate").datepicker( "option", "maxDate", selectedDate );
                // }    
 
            });    
    });
</script>

<script type="text/javascript">

	$(function() {
//	alert($(""));

		var flag=false;
		$("#insertBtn").click(function() {

	/* 
			var datatimeRegexp = /[0-9]{4}-[0-9]{2}-[0-9]{2})/;
		//|| !datatimeRegexp.test($("#inDate").val()) 
		    if ( !datatimeRegexp.test( $("#orderDate").val())  ) {
		        alert("날짜는 yyyy-mm-dd 형식으로 입력해주세요.");
		        return false;
		    }
 */
			chkNull();
		 
			if (flag==false){ 
			
		location.href="inventory_insert.jsp?originalItemName="
				+originalItemName+"&prjName="+$("#prjName").val()+"&empName="+$("#empName").val()
				+"&item="+$("#item").val()+"&orderDate="+  $("#orderDate").val()+"&inDate="+$("#inDate").val()
				+"&unit="+ $("#unit").val()+"&standardQnt="+$("#standardQnt").val()
				+"&currentQnt="+$("#currentQnt").val();
			}else{
				location.href="inventory.jsp";
			} 
		});//click
		
		
		var data="";
		var originalItemName="";
		
		$("#modifyBtn").click(function() {
		
			//$.each(배열,function(인덱스용매개변수,배열 방의 값을 저장 할 매개변수)
			$('.itemName').each(function(i,obj) {  
				if($(obj).is(':checked')){ //radio 선택됐으면
					//radio(obj) 다음(next)에 나온<span>에 넣은 값을 csv로 얻어 
					// ,로 잘라서 선택한 항목 값의 배열
		        	var modifyData=$(obj).next().html().split(","); 

					/* 선택 항목 값 select, input에 넣어주기(맨 윗줄)  */
		        	 $("#prjName").val( modifyData[0]);
		        	 $("#empName").val( modifyData[1]);
		        	 $("#item").val( modifyData[2]);
		        	 $("#orderDate").val( modifyData[3]);
		        	 $("#inDate").val( modifyData[4]);
		        	 $("#unit").val( modifyData[5]);
		        	 $("#standardQnt").val( modifyData[6]);
		        	 $("#currentQnt").val( modifyData[7]);
		        	 $("#status").val( modifyData[8]);
	
		        	 
		        	 data = "radioChecked&saveBtnClicked";
		        	 originalItemName=modifyData[2];
		        
			    }//end if
		    });
			
			if(data !="radioChecked&saveBtnClicked"){
				alert("수정항목을 선택해주세요");
			}//end if
			 
		});//click
		
		
		$("#saveModifyBtn").click(function() {
			
			if(data == "radioChecked&saveBtnClicked"){
				chkNull();
				location.href="inventory_savemdf.jsp?originalItemName="
				+originalItemName+"&prjName="+$("#prjName").val()+"&empName="+$("#empName").val()
				+"&item="+$("#item").val()+"&orderDate="+  $("#orderDate").val()+"&inDate="+$("#inDate").val()
				+"&unit="+ $("#unit").val()+"&standardQnt="+$("#standardQnt").val()
				+"&currentQnt="+$("#currentQnt").val();
			}else{
				alert("수정항목을 선택해주세요");
			}//end else
			
		});//clickSaveMdf
		
		
		$("#delBtn").click(function() {//click delete
			
			$('input:radio[name=itemName]').each(function() {
		         if($(this).is(':checked'))
		        	 data = $(this).val();
		      });
			
			if(data !=""){//if there is itemName, ask if they really want to delete
				if(confirm("선택한 재고를 삭제하시겠습니까?")){
					location.href="inventory_del.jsp?itemName="+data;
				}else{
					alert("재고 삭제를 취소 했습니다.");
				}//end else
					
			}else{
				alert("삭제할 재고를 선택하세요.");
			}//end else
			
		});//click

	}); //ready

	
	function chkNull() {

		if ($("#prjName").val() == undefined || $('#empName').val() == undefined
				|| $("#item").val() == "" || $("#inDate").val() == ""
				|| $("#outDate").val() == "" || $("#unit").val() == ""
				|| $("#standardQnt").val() == ""
				|| $("#currentQnt").val() == "") {
			alert("누락된 항목이 없는지 확인해 주세요");
			falg=true;
			return flag;
		}//end if
	
	}//chkNull


	function chkDate(){
		
	}//chkDate

</script>
</head>

<body>
	<div id="wrapper">
	
		<div id="header">
				
			<jsp:include page="../common/jsp/menu.jsp"/>
							
			<div id="title">
				<h3 style="font-weight: bold">재고관리</h3>
			</div>
		</div>

		<div id="container">
			<div class="table-responsive">
				<div id="btn-group" align="right" style="margin-right:20px; margin-bottom: 30px" >
					<button type="button" class="btn btn-outline-info" id="insertBtn"	class="btnAdd">재고 추가</button> 
					<button type="button" class="btn btn-outline-info" id="modifyBtn">재고 수정</button>
					<button type="button" class="btn btn-outline-info" id="saveModifyBtn">수정 저장</button>
					<button type="button" class="btn btn-outline-info" id="delBtn"	class="btnDel">재고 삭제</button>
				</div>
				
				<form id="frm" action="inventory_savemdf.jsp" method="get">
					<div style="overflow-y:scroll: auto" >
					<table class="myTable">
						<thead>
						<tr class="header">
							<th></th>
							<th>프로젝트명</th>
							<th>재고담당자</th>
							<th>재고품목</th>
							<th>발주일자</th>
							<th>입고일자</th>
							<th>단위</th>
							<th>적정재고</th>
							<th>현재고</th>
							<th>부족</th>
						</tr>
						</thead>
						<tbody>
						<tr class="header-sub">
							<td></td>
							<td>
							<select id="prjName" name="prjName" style="width:150px">
								<option>선택</option>
								<%
								//프로젝트명 option에 보여주기
								InventoryDAO iDao=InventoryDAO.getInstance();
								List<String> listPrjName=iDao.selectPrj();
								for(int i=0; i< listPrjName.size() ; i++){
								%>	
									<option><%=listPrjName.get(i)%></option>
								<%	}//end for %>
							</select>
							</td>
							
							<td>
							<select id="empName" name="empName" style="width:150px">
								<option>선택</option>
								<%
								//구매부서 직원 option에 보여주기
								iDao=InventoryDAO.getInstance();
								List<String> listEname=iDao.selectEmp();
								for(int i=0; i< listEname.size() ; i++){
								%>	
									<option><%=listEname.get(i)%></option>
								<%	}//end for %>
							</select>
							</td>
							
							<td><input type="text" size="15px" id="item" name="item" /></td>
							<td><input type="text" size="15px" id="orderDate" name="orderDate" placeholder="yyyyMMdd" readonly/></td>
							<td><input type="text" size="15px" id="inDate" name="inDate" placeholder="yyyyMMdd" readonly/></td>
							<td><input type="text" size="8px" id="unit" name="unit" /></td>
							<td><input type="text" size="4px" id="standardQnt" name="standardQnt"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자" /></td>
							<td><input type="text" size="4px" id="currentQnt" name="currentQnt" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="숫자" /></td>
							<td><input type="text" size="4px"  id="status" name="status" readonly /></td>
						</tr>
	
						<%
						//재고현황 출력
						List<InventoryVO> listIvt=iDao.selectAllInventory();
						for(InventoryVO ivtVO : listIvt){
						%>
						<tr>
						<td><input type="radio" class="itemName" name="itemName" value="<%=ivtVO.getItemName()%>"/>
							<span style="display:none"><%=ivtVO.getPrjName() %>,<%=ivtVO.getEmpName() %>,<%=ivtVO.getItemName() %>,<%=ivtVO.getOrderDate() %>,<%=ivtVO.getInStockDate() %>,<%=ivtVO.getUnit() %>,<%=ivtVO.getOptiStock() %>,<%=ivtVO.getCurStock() %>,<%=ivtVO.getStatus() %>
							</span>
						</td>
						<td><%=ivtVO.getPrjName() %></td>
						<td><%=ivtVO.getEmpName() %></td>
						<td><%=ivtVO.getItemName() %></td>
						<td><%=ivtVO.getOrderDate() %></td>
						<td><%=ivtVO.getInStockDate() %></td>
						<td><%=ivtVO.getUnit() %></td>
						<td><%=ivtVO.getOptiStock() %></td>
						<td><%=ivtVO.getCurStock() %></td>
						<td><%=ivtVO.getStatus() %></td>
						</tr>
						<% } //end for %>
						</tbody>
					</table>
				</div>
			</form>
		</div>
	</div>
		<div id="footer">
			<p>
				With supporting text below as a natural lead-in to additional
				content.<br /> &copy; SSangyong Group. All rights reserved.
			</p>
		</div>
	</div>
</body>

</html>