<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="삭제하기 : 사용자가 선택한 프로젝트를 삭제하고, 프로젝트 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
	//파라메터 값 받기 
	String prjCode=request.getParameter("prjCode");
	
	//DB에 값 추가 
	ProjectDAO pDao=ProjectDAO.getInstance();
	
	String msg="프로젝트를 삭제하지 못했습니다.";
	try{
  		 int cnt=pDao.deleteProjectMng(prjCode); //삭제  
   	//삭제성공 
   	if( cnt == 1 ){
   		msg="프로젝트를 삭제하였습니다.";
   	}//end if 
   }catch(SQLException se){ //추가 실패 
   	msg="문제가 발생하였습니다. 잠시 후에 다시 시도해주세요.";
   	se.printStackTrace();
   }
%>

alert("<%= msg %>");
location.href="prj_mng.jsp"
</script>