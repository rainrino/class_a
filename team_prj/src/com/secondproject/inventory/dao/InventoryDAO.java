package com.secondproject.inventory.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.secondproject.inventory.vo.InventoryVO;



public class InventoryDAO {

	private static InventoryDAO i_dao;

	private InventoryDAO() {

	}
	public static InventoryDAO getInstance() {

		if( i_dao == null )  {
			i_dao=new InventoryDAO();

		}//end if
		return i_dao;
	}//getInsatnce

	private Connection getConn()throws SQLException{

		Connection con=null;
		try {
			Context ctx= new InitialContext();
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/team_dbcp");
			con=ds.getConnection();

		} catch (NamingException e) {
			e.printStackTrace();
		}//end catch

		return con;
	}//getConn

	public List<InventoryVO>selectAllInventory() throws SQLException {

		List<InventoryVO> listIvt = new ArrayList<InventoryVO>();

		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;


		try {
			con=getConn();
			StringBuilder selectInventory= new StringBuilder();
			selectInventory
			.append("  select prj_name,emp_name,ITEM_NAME, ORDER_DATE, INSTOCK_DATE, UNIT,OPTI_STOCK, CUR_STOCK,cur_stock-opti_stock CONDITION ")
			.append("   	from project p,inventory i,emp e  ")
			.append("   where p.prj_code=i.prj_code and i.emp_no=e.emp_no  ")
			.append(" order by p.prj_code   ");


			pstmt=con.prepareStatement(selectInventory.toString());


			InventoryVO ivtVO=null; 


			rs=pstmt.executeQuery();

			while(rs.next()) {
				if(Integer.parseInt(rs.getString("condition"))<0) {
					ivtVO = new InventoryVO(rs.getString("prj_name"),rs.getString("emp_name"),rs.getString("item_name"),
							rs.getString("order_date"),rs.getString("instock_date"),rs.getString("unit"),rs.getInt("opti_stock"),
							rs.getInt("cur_stock"),"부족");

					listIvt.add(ivtVO);

				}else{
					ivtVO=new InventoryVO(rs.getString("prj_name"),rs.getString("emp_name"),rs.getString("item_name"),
							rs.getString("order_date"),rs.getString("instock_date"),rs.getString("unit"),rs.getInt("opti_stock"),
							rs.getInt("cur_stock")," ");
					listIvt.add(ivtVO);
				}//end else

			}//end while

		}finally {
			if(rs !=null) {rs.close();}
			if(pstmt !=null) {pstmt.close();}
			if(con !=null) {con.close();}
		}//finally

		return listIvt;
	}//selectAllInventory


	public List<String> selectEmp()throws SQLException{

		List<String> listEname=new ArrayList<String>();
		Connection con=null;
		PreparedStatement pstmt=null;

		ResultSet rs=null; 
		try {
			//3.
			con=getConn();
			//4.
			String selectPurchaseEmp="select emp_name from emp where dept_name='구매' ";

			pstmt=con.prepareStatement(selectPurchaseEmp);

			//5.
			rs=pstmt.executeQuery();

			while( rs.next()){

				listEname.add(rs.getString("emp_name"));
			}//end while

		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 

		return listEname;

	}//selectEmp

	public List<String> selectPrj()throws SQLException{

		List<String> listPrjName=new ArrayList<String>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null; 
		try {
			//3.
			con=getConn();
			//4.
			String selectProjectName="select prj_name from project";

			pstmt=con.prepareStatement(selectProjectName);

			rs=pstmt.executeQuery();

			while( rs.next()){

				listPrjName.add(rs.getString("prj_name"));
			}//end while

		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 

		return listPrjName;

	}//selectEmp

	public String selectItemName(String itemName) throws SQLException{
		String resultItemName="";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null; 
		try {
			//3.
			con=getConn();
			//4.
			String selectItemName=" select item_name from inventory where item_name =?  ";

			pstmt=con.prepareStatement(selectItemName);
			pstmt.setString(1, itemName);

			//5.
			rs=pstmt.executeQuery();

			if( rs.next()){

				resultItemName=rs.getString("item_name");
			}//end if

		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}
		return resultItemName;
	}//selectItemName

	public void insertInventory(InventoryVO ivtVO) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;


		try {
			//3.
			con=getConn();
			//4.
			StringBuilder insertInventory=new StringBuilder();
			insertInventory
			.append(" insert into inventory (PRJ_CODE, EMP_NO, ITEM_NAME, ORDER_DATE, INSTOCK_DATE,  ")
			.append(" UNIT, OPTI_STOCK, CUR_STOCK, CONDITION) values((select prj_code from project  ")
			.append(" where prj_name=?), (select emp_no from emp where dept_name='구매' and  ")
			.append(" emp_name=?), ?, ?, ?, ?, ?, ?, '' )  ");


			pstmt=con.prepareStatement(insertInventory.toString());
			pstmt.setString(1,ivtVO.getPrjName());
			pstmt.setString(2,ivtVO.getEmpName());
			pstmt.setString(3,ivtVO.getItemName());
			pstmt.setString(4,ivtVO.getOrderDate());
			pstmt.setString(5,ivtVO.getInStockDate());
			pstmt.setString(6,ivtVO.getUnit());
			pstmt.setInt(7,ivtVO.getOptiStock());
			pstmt.setInt(8,ivtVO.getCurStock());

			//5.
			pstmt.executeUpdate();
		}finally {
			//6.

			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 

	}//insertInventory



	/**
	 * 占쏙옙占� 占쏙옙占쏙옙 占싹댐옙 占쏙옙
	 * @return
	 * @throws SQLException 
	 */
	public int updateInventory(InventoryVO ivtVO,String originalItemName) throws SQLException {
		int cnt=0;

		Connection con=null;
		PreparedStatement pstmt=null;

		try {
			//3
			con=getConn();
			//4
			StringBuilder updateInventory=new StringBuilder();
			updateInventory
			.append(" update inventory	 ")
			.append(" 	 set prj_code=(select prj_code from project where prj_name=?),	")
			.append(" 	item_name=?, order_date=?, instock_date=?, 	")
			.append(" 	 	unit=?, opti_stock=?, cur_stock=? ,emp_no=(select emp_no from emp where emp_name=?) ")
			.append(" 	where item_name=? 	");

			pstmt=con.prepareStatement(updateInventory.toString());

			//占쏙옙占싸드변占쏙옙
			pstmt.setString(1,ivtVO.getPrjName());
			pstmt.setString(2,ivtVO.getItemName());
			pstmt.setString(3,ivtVO.getOrderDate());
			pstmt.setString(4,ivtVO.getInStockDate());
			pstmt.setString(5,ivtVO.getUnit());
			pstmt.setInt(6,ivtVO.getOptiStock());
			pstmt.setInt(7,ivtVO.getCurStock());
			pstmt.setString(8, ivtVO.getEmpName());
			pstmt.setString(9, originalItemName);


			//5
			cnt=pstmt.executeUpdate();//占쏙옙占쏙옙 占쏙옙占쏙옙1 占쏙옙占쏙옙0
			//6

		}finally {
			if(pstmt !=null){ pstmt.close();}
			if(con !=null){ con.close();}

		}//end finally

		return cnt;
	}//updateInventory


	/**
	 * itemName占쏙옙 占쌨억옙 占쌔댐옙 占쏙옙占� 占쏙옙占쏙옙占싹댐옙 占쏙옙
	 * @param itemName
	 * @return
	 * @throws SQLException
	 */
	public int deleteInventory(String itemName) throws SQLException {
		int cnt=0;

		Connection con=null;
		PreparedStatement pstmt=null;

		try {
			//3
			con=getConn();
			//4
			String deleteInventory=" delete from inventory where item_name=? ";
			pstmt=con.prepareStatement(deleteInventory);

			//占쏙옙占싸드변占쏙옙
			pstmt.setString(1, itemName);

			//5
			cnt=pstmt.executeUpdate();//占쏙옙占쏙옙 占쏙옙占쏙옙1 占쏙옙占쏙옙0

			//6

		}finally {
			if(pstmt !=null){ pstmt.close();}
			if(con !=null){ con.close();}

		}//end finally

		return cnt;
	}//deleteInventory



}//class

