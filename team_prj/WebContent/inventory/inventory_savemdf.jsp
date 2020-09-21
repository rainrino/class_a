<%@page import="java.sql.SQLException"%>
<%@page import="com.secondproject.inventory.dao.InventoryDAO"%>
<%@page import="com.secondproject.inventory.vo.InventoryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
<%
	InventoryVO iVO=new InventoryVO();
//파라메터 값 받기

	//변경 전 itemName의 값
	String originalItemName=request.getParameter("originalItemName");

	//변경 후의 값
	iVO.setPrjName(request.getParameter("prjName"));
	iVO.setEmpName(request.getParameter("empName"));
	iVO.setItemName(request.getParameter("item"));
	iVO.setOrderDate(request.getParameter("orderDate"));
	iVO.setInStockDate(request.getParameter("inDate"));
	iVO.setUnit(request.getParameter("unit"));
	String standardQnt=request.getParameter("standardQnt").trim();
	String currentQnt=request.getParameter("currentQnt").trim();
	
	if(standardQnt == null){
		standardQnt="";
	}
	if(currentQnt == null){
		currentQnt="";
		
	}
	
	iVO.setOptiStock(Integer.parseInt(standardQnt));
	iVO.setCurStock(Integer.parseInt(currentQnt));
	iVO.setStatus(request.getParameter("status"));
//DB 값 추가
	InventoryDAO iDAO=InventoryDAO.getInstance();
	String msg="수정사항을 저장하지 못했습니다.";
	try{	

	//같은 재고 품목이 없거나 수정 전 이름과 같을 때만 수정 가능( 이미 존재하는 다른 품목과 같은 이름으로 변경 불가)
	if("".equals(iDAO.selectItemName(iVO.getItemName() ) ) ||  originalItemName.equals(iDAO.selectItemName(iVO.getItemName() ) )  ){

	int cnt=iDAO.updateInventory(iVO,originalItemName);//성공1 실패0
		if(cnt ==1){
	 	msg="수정사항을 저장하였습니다.";
 		}//end if
	}else{
		msg="이미 같은 이름의 재고가 존재합니다.";
			
		}//end else

	}catch (RuntimeException re){
	 	msg="잠시 후 다시 시도해주세요";
	}
%>

	alert("<%=msg%>");
	location.href="inventory.jsp"
</script>