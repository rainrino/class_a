<%@page import="com.secondproject.process.vo.UpdateProcessVO"%>
<%@page import="com.secondproject.process.dao.ProcessDAO"%>
<%@page import="com.secondproject.process.vo.InsertProcesssVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공정을 수정한 후 저장하는 일"
%>
<script type="text/javascript">
<%
	UpdateProcessVO upVO = new UpdateProcessVO();
	//파라메터 값 받기

	//변경 후의 값
	upVO.setProjectName(request.getParameter("prj_name"));
	upVO.setOld_prj_name(request.getParameter("old_prj_name"));
	upVO.setProjectMgr(request.getParameter("prj_mgr"));
	upVO.setDeptName(request.getParameter("dept_name"));
	upVO.setProcessName(request.getParameter("process_name"));
	upVO.setStart_date(request.getParameter("start_date"));
	upVO.setComplete_date(request.getParameter("complete_date"));
	upVO.setWorking_days(Integer.parseInt(request.getParameter("working_days")));
	upVO.setNote(request.getParameter("note"));
	upVO.setProcessName(request.getParameter("process_name"));
	
	//DB 값 추가
	ProcessDAO pDao = ProcessDAO.getInstance();
	
	String msg="수정사항을 저장하지 못했습니다.";
	
	try{	

	int cnt = pDao.updateProcess(upVO);//성공1 실패0
		if(cnt ==1){
	 	msg="수정사항을 저장하였습니다.";
 	}//end if

	}catch (RuntimeException re){
	 	msg="잠시 후 다시 시도해주세요";
	}//end catch
%>
	alert("<%= msg %>"); 
	location.href="process.jsp"
</script>
