<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.inventory.dao.InventoryDAO"%>
<%@page import="com.secondproject.inventory.vo.InventoryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="inventory에 값 추가"%>
<script type="text/javascript">
<%
InventoryVO iVO=new InventoryVO();
//파라메터 값 받아 VO에 넣기
	String msg="";
	try{
	iVO.setPrjName(request.getParameter("prjName"));
	iVO.setEmpName(request.getParameter("empName"));
	iVO.setItemName(request.getParameter("item"));
	iVO.setOrderDate(request.getParameter("orderDate"));
	iVO.setInStockDate(request.getParameter("inDate"));
	iVO.setUnit(request.getParameter("unit"));
	int standardQnt=Integer.parseInt(request.getParameter("standardQnt").trim());
	int currentQnt=Integer.parseInt(request.getParameter("currentQnt").trim());
	
	iVO.setOptiStock(standardQnt);
	iVO.setCurStock(currentQnt);
	iVO.setStatus(request.getParameter("status"));
	//DB 값 추가
	InventoryDAO iDAO=InventoryDAO.getInstance();
	
	//같은 이름 재고 품목있는지 확인
	
	if("".equals(iDAO.selectItemName(iVO.getItemName() ) ) ){//같은 품목이 없다면
	iDAO.insertInventory(iVO); //추가
		
	msg="재고를 추가하였습니다.";
	}else{
	
		msg="이미 존재하는 재고는 추가하실 수 없습니다.";
		
	}//end else

	}catch(RuntimeException re){

	msg="문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
	}
%>

alert("<%= msg %>");
location.href="inventory.jsp";
</script>
    