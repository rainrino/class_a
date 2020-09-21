<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="부서추가 클릭 시 나타나는 창"
    %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<h3 style="font-weight: bold" id="deptInsertH3">부서추가</h3>
<input type="text" id="deptInsertDeptName" name="deptInsertDeptName" placeholder="ex)디자인">
<div class="deptBtnDiv">
	<span><button type="button" class="btn btn-info" id="deptInsertBtn" >확인</button></span>
	<span><button type="button" class="btn btn-info" id="deptInsertCancel" onclick="cancelBtn();" >취소 </button></span><br/>
</div>