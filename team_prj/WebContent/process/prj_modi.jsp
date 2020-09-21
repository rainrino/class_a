<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.project.vo.ProjectVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secondproject.project.vo.ProjectMngVO"%>
<%@page import="java.util.List"%>
<%@page import="com.secondproject.project.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="수정하기 : 사용자가 수정한 값을 DB에 넣고, 프로젝트 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">
<%
ProjectMngVO pmVO=new ProjectMngVO();
//파라메터 값 받기 
pmVO.setPrjCode(request.getParameter("prjCode"));
pmVO.setPrjName(request.getParameter("prjName"));
pmVO.setStartdate(request.getParameter("startdate"));
pmVO.setEnddate(request.getParameter("enddate"));
pmVO.setPrjMng(request.getParameter("prjMng"));

System.out.println(pmVO.getPrjCode()+" / "+pmVO.getPrjName()+" / "+pmVO.getStartdate()+" / "+pmVO.getEnddate()+" / "+pmVO.getPrjMng());
//DB에 값 추가 
ProjectDAO pDao=ProjectDAO.getInstance();

String msg="프로젝트를 변경하지 못했습니다.";
try{
	int cnt=pDao.updateProjectMng(pmVO); //변경  
	//추가성공 
	if( cnt == 1){
		msg="프로젝트를 변경하였습니다.";
	}//end if 
}catch(SQLException se){ //추가 실패 
	msg="문제가 발생하였습니다. 잠시 후에 다시 시도해주세요.";
	se.printStackTrace();
}
%>

alert("<%= msg %>");
location.href="prj_mng.jsp"
</script>
