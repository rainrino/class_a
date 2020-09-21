<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="추가하기 : 사용자가 입력한 값을 DB에 넣고, 프로젝트 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
	ProjectVO pVO=new ProjectVO();
	//파라메터 값 받기 
	pVO.setPrjName(request.getParameter("prjName"));
	pVO.setStartdate(request.getParameter("startdate"));
	pVO.setEnddate(request.getParameter("enddate"));
	pVO.setPrjMng(request.getParameter("prjMng"));
	
	//DB에 값 추가 
	ProjectDAO pDao=ProjectDAO.getInstance();
	
	pDao.insertProjectMng(pVO); //추가
		
	String msg="프로젝트를 추가하였습니다.";
	
%>

alert("<%= msg %>");
location.href="prj_mng.jsp"
</script>


