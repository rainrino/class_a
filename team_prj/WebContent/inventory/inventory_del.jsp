<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.inventory.dao.InventoryDAO"%>
<%@page import="com.secondproject.inventory.vo.InventoryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="재고를 삭제하는 일"%>
<script type="text/javascript">
<%

//파라메터 값 설정
String itemName=request.getParameter("itemName");

//DB 값 삭제
InventoryDAO ivtDao=InventoryDAO.getInstance();

String msg="해당 재고를 삭제하지 못했습니다.";
try{

	int cnt=ivtDao.deleteInventory(itemName);//삭제
//추가 성공
	if(cnt==1){
	 
	msg="해당 재고를 삭제하였습니다";
	
		 }//end if
}catch(SQLException se){//삭제 실패
	msg="문제가 발생하였습니다. 잠시 후 다시 시도해주세요";
	se.printStackTrace();
}

%>

alert("<%=msg%>");
location.href="inventory.jsp"




</script>