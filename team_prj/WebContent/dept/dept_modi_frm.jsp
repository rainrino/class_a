<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.dept.vo.DeptVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.dept.dao.DeptDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="부서수정 클릭 시 나타나는 창" 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <form action="dept_modi.jsp" id="deptModiFrm" method="get">
	<h3 style="font-weight: bold" id="deptModiH3">부서수정</h3>
	<h6 style="font-weight: bold;margin: 2%">수정할 부서 선택</h6> 
	<select  id="deptModiSelect" name="deptModiSelect">
					<% 
						//모든 부서 출력하기 (관리자)
						DeptDAO dDao=DeptDAO.getInstance();
						List<DeptVO> listDept=new ArrayList<DeptVO>();
						listDept=dDao.allSelectDept();
						
						if(listDept.size() != 0){%>
							<option value="all">전체</option>
							<% for(DeptVO dVO : listDept ) { %>
							<option value="<%= dVO.getDeptNo() %>" ><%= dVO.getDeptName() %></option>
							<% }//end for 
						}else{%>
							<option value="empty">부서없음</option>
						<% 
						}//end if 
						%>
	</select>
	<h6 style="font-weight: bold;margin: 2%">수정할 부서명</h6>
	<input type="text" id="deptModiDeptName" name="deptInsertDeptName" placeholder="ex)디자인">
	<div class="deptBtnDiv">
		<span><button type="button" class="btn btn-info" id="deptModiBtn" >확인</button></span>
		<span><button type="button" class="btn btn-info" id="deptModiCancel" onclick="cancelBtn();" >취소 </button></span><br/>
	</div>
</form>