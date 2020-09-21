<%@page import="com.secondproject.process.vo.InsertProcesssVO"%>
<%@page import="oracle.net.aso.p"%>
<%@page import="com.secondproject.process.dao.ProcessDAO"%>
<%@page import="com.secondproject.process.vo.SelectProcessVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="공정 추가하기 : 사용자가 입력한 값을 DB에 넣고, 공정관리 리스트 조회 페이지로 이동"
	%>
<script type="text/javascript">

<%
	InsertProcesssVO ipVO = new InsertProcesssVO();
	
	String msg = "해당 공정을 추가하지 못했습니다.";

	//파라메터 값 받기	
	try {
		ipVO.setProjectName(request.getParameter("prj_name"));
		ipVO.setProjectMgr(request.getParameter("prj_mgr"));
		ipVO.setDeptName(request.getParameter("dept_name"));
		ipVO.setProcessName(request.getParameter("process_name"));
		ipVO.setStart_date(request.getParameter("start_date"));
		ipVO.setComplete_date(request.getParameter("complete_date"));
		ipVO.setWorking_days(Integer.parseInt(request.getParameter("working_days")));
		ipVO.setNote(request.getParameter("note"));
		
		//DB에 값 추가
		ProcessDAO pDao = ProcessDAO.getInstance();
		
		int cnt = pDao.insertProcess(ipVO);//추가;
		if( cnt == 1 ){ 
			msg = "공정을 추가하였습니다.";
		}//end if 
		
	}catch(RuntimeException re){
		msg="문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
		re.printStackTrace();
	}//end catch
%>

alert("<%= msg %>");
location.href="process.jsp"

</script>
	
