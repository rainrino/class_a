package com.secondproject.dept.dao;

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

import com.secondproject.dept.vo.DeptVO;
import com.secondproject.dept.vo.EmpDeptVO;
import com.secondproject.dept.vo.ModifyDeptVO;

public class DeptDAO {
private static DeptDAO d_dao;
	
	private DeptDAO() {
		
	}
	
	public static DeptDAO getInstance() {
		if( d_dao == null) {
			d_dao=new DeptDAO();
		}//end if 
		return d_dao;
	}//getInstance
	
	
	public Connection getConn() throws SQLException{
		Connection con=null;
		
		try {
			Context ctx=new InitialContext();
			
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/team_dbcp");
			
			con=ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return con;
	}

	public List<DeptVO> allSelectDept() throws SQLException {
		List<DeptVO> listDept=new ArrayList<DeptVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			con=getConn();
			String selectProject="  select dept_name, dept_no from dept_table order by dept_no	";
			pstmt=con.prepareStatement(selectProject);
			rs=pstmt.executeQuery();
			DeptVO deptVO=null;
			
			while( rs.next() ) {
				deptVO=new DeptVO(rs.getString("dept_name"), rs.getString("dept_no"));
				listDept.add(deptVO);
			
			}//end while
		}finally {	
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return listDept;
		
	}//allSelectDept
	
	public List<EmpDeptVO> selectDeptEmp(String deptNo ) throws SQLException {
		List<EmpDeptVO> listEmpDept=new ArrayList<EmpDeptVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			con=getConn();
			StringBuilder selectEmpDept=new StringBuilder();
			selectEmpDept.append("	 select p.position, emp_name from emp e, position p 	")		
			.append("	 where p.position = e.position 	");		
			
			if(deptNo != "all") { 
				selectEmpDept.append("	 and dept_no='")
				.append(deptNo)
				.append("'	");
			}//end if 
			selectEmpDept.append("	 order by p.position_no asc 	");		
			
			pstmt=con.prepareStatement(selectEmpDept.toString());
			
		//4.
			rs=pstmt.executeQuery();
			
			EmpDeptVO empDeptVO=null;
			
			while( rs.next() ) {
				if("∏∂Ω∫≈Õ".equals(rs.getString("position"))) {
					continue;
				}
				empDeptVO=new EmpDeptVO(rs.getString("position"), rs.getString("emp_name"));
				listEmpDept.add(empDeptVO);
			
			}//end while
		}finally {	
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return listEmpDept;
		
	}//allSelectDept
	
	public void insertDept( String deptName ) throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			StringBuilder insertDept=new StringBuilder();
			insertDept
			.append("	insert into dept_table	")
			.append("	(dept_name, dept_no, dept_inputdate)	")
			.append("	values('"+deptName+"', dep_seq.nextval, to_char(sysdate,'yymmdd'))	");
			
			pstmt=con.prepareStatement(insertDept.toString());
			
			//5.
			pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
	}//insertDept
	
	public int updateDept( ModifyDeptVO mdVO ) throws SQLException{
		
		int rowCnt=0; 
	
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			StringBuilder updateProject=new StringBuilder();
			updateProject
			.append("	update dept_table 	")
			.append("	set dept_name='"+mdVO.getDeptName()+"'	")
			.append("	where dept_no='"+mdVO.getDeptNo()+"'	");
			
			pstmt=con.prepareStatement(updateProject.toString());

			//5.
			rowCnt=pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return rowCnt;
	}//updateDept
	
	public int deleteDept( int deptNo ) throws SQLException{
		
		int rowCnt=0; 

		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConn();
			String deleteProject="delete from dept_table where dept_no='"+deptNo+"' ";
			 
			pstmt=con.prepareStatement(deleteProject);
			rowCnt=pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return rowCnt;
	}//deleteDept
	
}//class
