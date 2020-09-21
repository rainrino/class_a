package com.secondproject.login.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.secondproject.login.vo.LoginVO;


public class LoginDAO {


	private static LoginDAO l_dao;
	
	private LoginDAO() {
		
	}//LoginDAO
	
	public static LoginDAO getInstance() {
		if(l_dao==null){
			l_dao=new LoginDAO();
		}
		return l_dao;
		
	}//getInstance
	
	private Connection getConn() throws SQLException{
		Connection con=null;
		
		try {
			Context ctx= new InitialContext();
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/team_dbcp");
			con=ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	
	/**
	 * 占쏙옙占싱듸옙占� 占쏙옙橘占싫ｏ옙占� 占쌉뤄옙占싹울옙 占쏙옙호화占쏙옙 占싱몌옙占쏙옙 占쏙옙占� 占쏙옙
	 * @return
	 * @throws SQLException
	 */
	public String selectName(LoginVO lVO)throws SQLException{
		String name = "";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
		con=getConn();
		String selectName=" select emp_name from emp where email = ? and password = ? ";
		pstmt=con.prepareStatement(selectName);
		pstmt.setString(1, lVO.getEmail().trim());
		pstmt.setString(2, lVO.getPassword().trim());
		
		
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			name = rs.getString("emp_name");
		}//end while
		
		}finally {
		if(rs !=null) {rs.close();}
		if(pstmt !=null) {pstmt.close();}
		if(con !=null) {con.close();}
		}//finally
		
		return name;
	}//selectName
	
	public String selectPosition(String email)throws SQLException{
		String position = "";
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			con=getConn();
			String selectPosition = " select position from emp where email=? ";
			pstmt=con.prepareStatement(selectPosition);
			pstmt.setString(1, email);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				position = rs.getString("position");
			}//end while
			
		}finally {
			//6占쏙옙占쏙옙 占쏙옙占쏙옙
			if(rs !=null) {rs.close();}
			if(pstmt !=null) {pstmt.close();}
			if(con !=null) {con.close();}
		}//finally
		return position;
	}//selectPosition

	
}//class