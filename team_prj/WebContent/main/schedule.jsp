<%@page import="java.util.StringTokenizer"%>
<%@page import="java.awt.Checkbox"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="com.secondproject.main.vo.ProjectMgrVO"%>
<%@page import="com.secondproject.main.vo.MainVO"%>
<%@page import="com.secondproject.main.dao.MainDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="스케쥴" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%!//declaration
	public static final int START_DAY = 1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄</title>
<link rel="stylesheet" type="text/css" href="../common/css/header.css">
<style type="text/css">
#wrap {
	width: 1600px;
	height: 800px;
	margin: 0px auto;
	position: absolute;
}

#header {
	width: 100%;
}

#container {
	width: 1500px;
	height: 780px;
	position: relative;
	margin: 0px auto;
	margin-top: 10px;
	margin-left: 230px;
}

#footer {
	min-width: 1902px;
	padding: 20px;
	position: relative;
	text-align: center;
	min-height: 100px;
	background-color: #F6F6F6;
	margin-top: 50px;
}

#title {
	margin-top: 130px;
	margin-right: 150px;
	margin-left: 250px;
}

#prjSelect {
	margin: 0px, auto;
}
/* sub-menu  */
ul {
	display: block;
	padding: 0px;
}

ul li {
	display: inline-block;
	position: relative;
}

ul li ul {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
}

ul li ul li {
	display: block;
}

ul li ul li ul {
	left: 100%;
	top: 0;
}

ul li:hover>ul {
	display: block;
	width: 120px;
}

.table-responsive {
	align-content: center;
	margin-right: 100px;
}

.myTable {
	width: 100%;
	height: 100%;
	border: 1px solid #ddd;
	font-size: 15px;
	text-align: center;
	border: 1px solid #ddd;
}

.myTable th {
	text-align: center;
	padding: 12px;
}

.myTable td {
	width: 190px;
	height: 100px;
	text-align: right;
	padding: 5px;
}

.myTable tr {
	border-bottom: 1px solid #ddd;
}

.myTable tr.header {
	background-color: #F6F6F6;
}

.toDayTd {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	background-color: #85dbf6;
	margin: 0px auto;
	text-align: center;
	float: right;
	text-align: center;
}

.dayToday {
	width: 100px;
	height: 15px;
	border-radius: 5%;
	margin: 0px auto;
	text-align: right;
	font-size: 15px;
}

/* .header-sub:hover {
	background-color: #F6F6F6; */
}
#btn {
	border: 1px solid #6799FF;
	outline: none;
	color: #6799FF;
	border-top-right-radius: 5px;
	border-top-left-radius: 5px;
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	background-color: rgba(0, 0, 0, 0);
	padding: 5px;
}

#btn:hover {
	color: white;
	background-color: #6799FF;
}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#prj_code").change(function() {

			$("#projectFrm").submit();
		});//change

	});//ready
	function chkBox() {
		$("#pro_code").each(function() {
			if ($("input:checkbox[name=checkbox]").is(":checked") == true) {
				if ($("input:checkbox[name=checkbox]:checked").length > 3) {
					alert("공정선택은 3개까지만 가능합니다.");
					return;
				}
			}
			$("#projectFrm").submit();
		});
	}
</script>
</head>
<body>
	<%
					Calendar cal = Calendar.getInstance();
					int nowYear = cal.get(Calendar.YEAR);//현재 년
					int nowMonth = cal.get(Calendar.MONTH) + 1;//현재 월
					int nowDay = cal.get(Calendar.DAY_OF_MONTH);//현재 일

					MainDAO maDAO = MainDAO.getInstance();
					
					String prj_code = request.getParameter("prj_code");
					String pro_code = request.getParameter("pro_code");
					
					StringBuilder toDay = new StringBuilder();
					//toDay에 이번년,월 저장
					toDay.append(nowYear).append(nowMonth);

					//월 받기
					String param_month = request.getParameter("param_month");

					if (param_month != null) {// 파라메터로 받은 월로 월을 설정한다.
						//0 1 2 3 4 5 6 7 8 9  10 11  자
						//1 2 3 4 5 6 7 8 9 10 11 12 사		
						cal.set(Calendar.DAY_OF_MONTH, 1); //모든 월에 존재하는 날짜를 설정하여 
						//다음 달 1일로 설정되지 않도록 한다.
						cal.set(Calendar.MONTH, Integer.parseInt(param_month) - 1);
					} //end if
					nowMonth = cal.get(Calendar.MONTH) + 1;//현재 월

					//년 받기
					String param_year = request.getParameter("param_year");

					if (param_year != null) {//파라메터로 받은 년으로 년을 설정한다.
						cal.set(Calendar.YEAR, Integer.parseInt(param_year));
					} //end if
					nowYear = cal.get(Calendar.YEAR);
					
					String[] queryArr = null;
					List<String> checkBoxList = new ArrayList<String>();
					if(request.getQueryString() != null){
						queryArr = request.getQueryString().split("&");
						if(queryArr.length<5){
							for(int i=0;i<queryArr.length;i++){
								checkBoxList.add(queryArr[i].substring(9));
							}
						}else{
					%>
					<script type="text/javascript">
							alert("공정은 최대 3개 선택 가능합니다. 다시 선택 해주세요.");
							location.href="schedule.jsp?prj_code=${param.prj_code}";
					</script>
					<%		
						}
						
					}
					
					
					boolean toDayFlag = toDay.toString().equals(nowYear + "" + nowMonth);//오늘은 표현할 것인지 판단하는 변수
					
					List<ProjectMgrVO> proList = new ArrayList<ProjectMgrVO>();
					proList = maDAO.proOtion(nowYear,nowMonth);
					%>
	<div id="wrap">
		<div id="header" align="right">
			<jsp:include page="../common/jsp/menu.jsp"></jsp:include>
			<div id="title"></div>
			<form id="projectFrm">
				<div id="processCheck" align="left"
					style="width: 200px; height: 600px; float: left; margin-left: 20px; margin-top: 70px; text-align: center;">
					<div id="prc_chk" align="left">
						<div id="prjSelect" align="left" style="margin-left: 40px;">
							<select id="prj_code" name="prj_code">
								<option>선택</option>
								<%
					for(int i=0;i<proList.size();i++){
					%>
								<option value="<%=proList.get(i).getPrj_code().trim() %>"
									<%=
								proList.get(i).getPrj_code().trim().equals(prj_code)?" selected='selected'":"" %>><%=
									proList.get(i).getPrj_name() %>
								</option>
								<%	
					}
					%>

							</select>
						</div>
						<%
						List<MainVO> maList = null;	
			if(prj_code != null){
			maList = maDAO.selectPro(nowYear,nowMonth,prj_code);
			for(int i=0;i<maList.size();i++){
			%>			
						<div style="margin-left: 50px; margin-top: 50px;">
							<input type="checkbox" name="pro_code" id="pro_code"
								value="<%=maList.get(i).getProcess_code().trim()%>"<%=
										checkBoxList.contains(maList.get(i).getProcess_code().trim())?" checked='checked'":"" %>/> <label><%=maList.get(i).getProcess_name().trim()%></label>
						</div>
						<%	
			//}
			}
			%>
					<div style="margin-left: 50px; margin-top: 50px;">
					<input type="button"id="btn"value="공정 보기"onclick="chkBox()"/>
					</div>
					<%
			}
					%>
					</div>
				</div>
			</form>
			<div id="container">
				<div class="table table-bordered" style="border: 0px;">

					<div id="calHeader"
						style="margin-bottom: 10px; align-items: left; border: 0px;">
						<a href="schedule.jsp" style="margin-left: 20px;"><img
							src="../common/images/btn_today.png" title="오늘" style="size:" /></a>
						<a
							href="schedule.jsp?param_month=<%=nowMonth - 1 == 0 ? 12 : nowMonth - 1%>&param_year=<%=nowMonth - 1 == 0 ? nowYear - 1 : nowYear%>"
							style="margin-left: 20px;"><img
							src="../common/images/btn_prev.jpg" title="이전 월" /></a> <a
							href="schedule.jsp?param_month=<%=nowMonth + 1 == 13 ? 1 : nowMonth + 1%>&param_year=<%=nowMonth + 1 == 13 ? nowYear + 1 : nowYear%>"
							style="margin-left: 20px;"><img
							src="../common/images/btn_next.jpg" title="다음 월" /></a> <span
							id="nowDate"
							style="margin-left: 20px; margin-top: 20px; font-size: 20px;"><%=nowYear%>년
							<%=nowMonth%>월</span>
					</div>


					<form action="" name="frm">
						<table class="myTable" style="margin-top: 30px;">

							<tr class="header">
								<th class="sunTitle">일</th>
								<th class="weekTitle">월</th>
								<th class="weekTitle">화</th>
								<th class="weekTitle">수</th>
								<th class="weekTitle">목</th>
								<th class="weekTitle">금</th>
								<th class="satTitle">토</th>
							</tr>
							<tr class="header-sub">
								<%
								String calTextCss = ""; //요일별 글자 색
								String tdCss = "";//오늘의 td색 
								for (int tempDay = START_DAY;; tempDay++) {
									cal.set(Calendar.DAY_OF_MONTH, tempDay);//증가하는 임시일자를 설정한다.

									if (tempDay != cal.get(Calendar.DAY_OF_MONTH)) {
										int nextDay = 0;// 다음 달 1일부터 출력
										//(일주일이 다음 달 날짜가 나오는경우를 막기 위해)끝일이 일요일이 아니면 공백을 넣는다.
										if (cal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
									//마지막날 이후에 빈칸을  생성
									for (int blankTd = cal.get(Calendar.DAY_OF_WEEK); blankTd < 8; blankTd++) {
								%>
								<td class="calTd"><%=cal.get(Calendar.MONTH) + 1%>/<%=++nextDay%></td>
								<%
									} //end for
								} //end if
								%>
							</tr>
							<%
								//증가하는 임시일자와 설정된 날짜가 다르다면 마지막날이므로 반복문을 빠져나간다.
							break;
							} //end if

							//if( tempDay == 1 ){//1일이라면 
							switch (tempDay) {
							case START_DAY:

								int blankTdCnt = cal.get(Calendar.DAY_OF_WEEK); //오늘의 요일 수얻기
								//이전월의 정보를 얻기위해 이전월로 설정한다. ( java는 사람의 월보다 1월 적음/)
								cal.set(Calendar.MONTH, nowMonth - 2);

								int prevMonth = cal.get(Calendar.MONTH) + 1; //이전월의 월을 얻는다.
								//이전월의 마지막날을 얻는다.
								int prevLastDay = cal.getActualMaximum(Calendar.DATE);
								// 예 : 28=30-4+2 : 이전달에 보여줄 일자는 28일 부터이다.
								prevLastDay = prevLastDay - blankTdCnt + 2;//마지막날의 시작일을 구한다. 

								//값을 모두 얻어왔으므로 현재달의 달력을 보여주기 위해 올해의 이번달로 설정한다.
								cal.set(Calendar.YEAR, nowYear); // 올해의  
								cal.set(Calendar.MONTH, nowMonth - 1); // 1월로 설정

								//1일을 출력하기 전에 공백을 출력(요일)
								for (int blankTd = START_DAY; blankTd < blankTdCnt; blankTd++) {
							%>
							<td class="calTd"><%=prevMonth%>/<%=prevLastDay++%></td>
							<%
								} //end for

							}//end switch
								//요일의 색을 설정하기위한 
							switch (cal.get(Calendar.DAY_OF_WEEK)) {
							case Calendar.SUNDAY:
								calTextCss = "sunText";
								break;
							case Calendar.SATURDAY:
								calTextCss = "satText";
								break;
							default:
								calTextCss = "weekText";
							}//end switch

							tdCss = "calTd"; //오늘이 아닌 날 설정
							if (toDayFlag && (tempDay == nowDay)) { //오늘
								tdCss = "toDayTd";
							} //end if
							%>
							<td>
								<div class="<%=tdCss%>"><%=tempDay%></div> 
							<%
							String[] processBar = {"../common/images/colorbar_2.png","../common/images/colorbar_3.png","../common/images/colorbar_6.png"};
							
							int cnt=0;
							if(queryArr != null){
							if(checkBoxList.size()<5){
								if(maList != null){
							
							for(int i=0;i<maList.size();i++){
								for(int j=1;j<queryArr.length;j++){
								if(maList.get(i).getProcess_code().trim().equals(checkBoxList.get(j))){	
								int start = Integer.parseInt(maList.get(i).getStart_date().substring(6));
								int com = Integer.parseInt(maList.get(i).getComplete_date().substring(6));
								for(int k=start;k<com+1;k++){
									if(tempDay == k){
										if(cnt == 3){
											cnt=0;
									}
								%>
								<div class="dayToday"
									style="background: url('<%=processBar[cnt]%>')repeat-x;">
									<%=maList.get(i).getProcess_name() %>
								</div> 
							<%
									}
							 }
								cnt++;
							}
							}
							}
							}
							}else{
							%>
							<script type="text/javascript">
							alert("공정은 최대 3개 선택 가능합니다. 다시 선택 해주세요.");
							</script>
							<%	
							}
							}
							%>
							</td>
							<%
							switch (cal.get(Calendar.DAY_OF_WEEK)) {
							case Calendar.SATURDAY: //토요일이면 줄 변경
							%>
							<tr>
								<%
									}//end switch

							}//end for
								%>
							
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
	</div>
</body>
</html>

