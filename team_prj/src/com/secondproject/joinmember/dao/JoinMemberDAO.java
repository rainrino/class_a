package com.secondproject.joinmember.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.secondproject.dept.vo.ModifyDeptVO;
import com.secondproject.joinmember.vo.JoinMemberVO;

public class JoinMemberDAO {
private static JoinMemberDAO jm_dao;
	
	private JoinMemberDAO() {
		
	}
	
	public static JoinMemberDAO getInstance() {
		if( jm_dao == null) {
			jm_dao=new JoinMemberDAO();
		}//end if 
		return jm_dao;
	}//getInstance
	
	
	private Connection getConn() throws SQLException{
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

	/**
	 *  ȸ�������� ��û�ϴ� �̸����� �ߺ��Ǵ��� Ȯ�� 
	 * @return 
	 * @throws SQLException
	 */
	public boolean selectId(String email) throws SQLException {
		boolean isIdDuplicated=false; //���̵� �ߺ��Ǵ���? false:�ߺ��ƴ� true:�ߺ�
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
		//1.
		//2.
			con=getConn();
		//3. ������ ���� ��ü �����
			String selectId="  select email from emp where email='"+email+"'	";
			pstmt=con.prepareStatement(selectId);
			
		//4.
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {
				isIdDuplicated=true;
			}//end if
		}finally {	
		//5. ���� ����
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return isIdDuplicated;
		
	}//allSelectDept
	
	
	/**
	 * ȸ�������� �Ϸ��� ����� ���� �߰�
	 * @param 
	 * @throws SQLException
	 */
	public void insertJoinMember( JoinMemberVO jmVO ) throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConn();
			//4.
			StringBuilder insertDept=new StringBuilder();
			insertDept
			.append("	insert into emp	")
			.append("	(emp_no, emp_name, password, email, hiredate)	")
			.append("	values('emp_'||emp_seq.nextval,	'"+jmVO.getEmpName()+"'	,	'"+jmVO.getPassword()+"',	'"+jmVO.getEmail()+"', 	to_char(sysdate, 'yymmdd'))	");
			
			
			pstmt=con.prepareStatement(insertDept.toString());
			
			//5.
			pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
	}//insertJoinMember
	
	/**
	 * �μ����� �����ϴ� ��
	 * @param pmVO
	 * @return
	 * @throws SQLException
	 */
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
	
	/**
	 * �μ��� �����ϴ� ��
	 * @param deptNo
	 * @return
	 * @throws SQLException
	 */
	public int deleteDept( int deptNo ) throws SQLException{
		
		int rowCnt=0; 

		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			String deleteProject="delete from dept_table where dept_no='"+deptNo+"' ";
			 
			pstmt=con.prepareStatement(deleteProject);
			//���ε� ������ �� �ֱ� 
			

			//5.
			rowCnt=pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return rowCnt;
	}//deleteDept
	
}//class
