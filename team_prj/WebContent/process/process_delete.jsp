<%@page import="com.secondproject.process.dao.ProcessDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	info="선택한 공정을 삭제하는 일"%>
<script type="text/javascript">
<%

//파라메터 값 받기 
String processCode = request.getParameter("processCode");

//DB에 값 추가 
ProcessDAO pDao = ProcessDAO.getInstance();

String msg = "해당 공정을 삭제하지 못했습니다.";
try {
	int cnt = pDao.deleteProcess(processCode); //삭제  
	//삭제 확인 1
	//삭제성공 
	if (cnt == 1) {
		msg = "해당 공정을 삭제하였습니다.";
	}//end if 

} catch (RuntimeException re) { //추가 실패 
	msg = "문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
	re.printStackTrace();
}//end catch
%>

alert("<%= msg %>");
location.href = "process.jsp"

</script>

