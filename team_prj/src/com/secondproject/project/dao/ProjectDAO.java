package com.secondproject.project.dao;

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

import com.secondproject.project.vo.ProjectMngVO;
import com.secondproject.project.vo.ProjectVO;

public class ProjectDAO {
private static ProjectDAO p_dao;
	
	private ProjectDAO() {
		
	}
	
	public static ProjectDAO getInstance() {
		if( p_dao == null) {
			p_dao=new ProjectDAO();
		}//end if 
		return p_dao;
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

	/**
	 * ������ ������Ʈ ����Ʈ ��ȸ (prj_code�߰��� ����Ʈ)
	 * @return 
	 * @throws SQLException
	 */
	public List<ProjectMngVO> selectAllProjectMng() throws SQLException {
		List<ProjectMngVO> listProjectMng=new ArrayList<ProjectMngVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
		//1.
		//2.
			con=getConn();
		//3. ������ ���� ��ü �����
			String selectProject="	select prj_code, prj_name, startdate, enddate, prj_mgr from project	";
			pstmt=con.prepareStatement(selectProject);
			
		//4.
			rs=pstmt.executeQuery();
			
			//��ȸ�� �÷� ���� �����ϱ� ���� VO���� 
			ProjectMngVO projectMngVO=null;
			
			while( rs.next() ) {
				//��ȸ�� �� ���� VO���� 
				projectMngVO=new ProjectMngVO(rs.getString("prj_code"), rs.getString("prj_name"), 
						rs.getString("startdate"), rs.getString("enddate"), rs.getString("prj_mgr"));
				//������ ������ VO�� list�� �߰� 
				listProjectMng.add(projectMngVO);
			
			}//end while
		}finally {	
		//5. ���� ����
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return listProjectMng;
		
	}//selectAllProjectMng
	
	/**
	 * �Ϲ� ����� ������Ʈ ����Ʈ ��ȸ
	 * @return
	 * @throws SQLException
	 */
	public List<ProjectVO> selectAllProject() throws SQLException {
		List<ProjectVO> listProject=new ArrayList<ProjectVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;	
		ResultSet rs=null;
		
		try {
		//1.
		//2.
			con=getConn();
		//3. ������ ���� ��ü �����
			String selectProject="	select prj_name, startdate, enddate, prj_mgr from project	";
			pstmt=con.prepareStatement(selectProject);
			
		//4.
			rs=pstmt.executeQuery();
			
			//��ȸ�� �÷� ���� �����ϱ� ���� VO���� 
			ProjectVO projectVO=null;
			
			while( rs.next() ) {
				//��ȸ�� �� ���� VO���� 
				projectVO=new ProjectVO(rs.getString("prj_name"), 
						rs.getString("startdate"), rs.getString("enddate"), rs.getString("prj_mgr"));
				//������ ������ VO�� list�� �߰� 
				listProject.add(projectVO);
			
			}//end while
		}finally {	
		//5. ���� ����
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return listProject;
		
	}//selectAllProject

	/**
	 * ������� �μ��� ����� ��ȸ�ϴ� ����Ʈ 
	 * @return ������� �μ��� ��� �̸� ����Ʈ 
	 * @throws SQLException
	 */
	public List<String> selectPrjMng() throws SQLException {
		List<String> listPrjMng=new ArrayList<String>();
		
		Connection con=null;
		PreparedStatement pstmt=null;	
		ResultSet rs=null;
		
		try {
		//1.
		//2.
			con=getConn();
		//3. ������ ���� ��ü �����
			String selectPrjMng="	select emp_name from emp where dept_no=410	";
			pstmt=con.prepareStatement(selectPrjMng);
			
		//4.
			rs=pstmt.executeQuery();
			
			//��ȸ�� �÷� ���� �����ϱ� ���� ���� ����
			String prjMng="";
			
			while( rs.next() ) {
				//��ȸ�� �� ���� VO���� 
				prjMng =rs.getString("emp_name");
				//������ ������ VO�� list�� �߰� 
				listPrjMng.add(prjMng);
			
			}//end while
		}finally {	
		//5. ���� ����
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return listPrjMng;
		
	}//selectPrjMng()
	
	/**
	 * ������Ʈ �߰�
	 * @param daVO
	 * @throws SQLException
	 */
	public void insertProjectMng( ProjectVO pVO ) throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			StringBuilder insertProject=new StringBuilder();
			insertProject
			.append("	insert into project	")
			.append("	(prj_code, prj_name, startdate, enddate, prj_mgr)	")
			.append("	values('prj_'||prj_seq.nextval, ?, ?, ?, ?)	");

			pstmt=con.prepareStatement(insertProject.toString());
			//���ε� ������ �� �ֱ� 
			pstmt.setString(1, pVO.getPrjName());
			pstmt.setString(2, pVO.getStartdate());
			pstmt.setString(3, pVO.getEnddate());
			pstmt.setString(4, pVO.getPrjMng());
	
			//5.
			pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
	}//insertProjectMng
	
	/**
	 * ������ ������Ʈ�� ������ �ҷ��� ���� �Է��ϴ� �� 
	 * @return
	 * @throws SQLException
	 */
	public ProjectVO selectModi(String prjCode) throws SQLException {
		ProjectVO pVO=new ProjectVO();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
		//1.
		//2.
			con=getConn();
		//3. ������ ���� ��ü �����
			String selectModi="	select prj_name, startdate, enddate, prj_mgr from project where prj_code='"+prjCode+"'	";
			pstmt=con.prepareStatement(selectModi);
			
		//4.
			rs=pstmt.executeQuery();
			
			if( rs.next()) {
			pVO=new ProjectVO(rs.getString("prj_name"), 
						rs.getString("startdate"), rs.getString("enddate"), rs.getString("prj_mgr"));
			}
		}finally {	
		//5. ���� ����
			if(rs != null) { rs.close(); } //end if 
			if(pstmt != null) { pstmt.close(); } //end if 
			if(con != null) { con.close(); } //end if 
		}//end finally 
		return pVO;
		
	}//selectAllProject
	
	
	/**
	 * ������Ʈ�� �����ϴ� ��
	 * @param pmVO
	 * @return
	 * @throws SQLException
	 */
	public int updateProjectMng( ProjectMngVO pmVO ) throws SQLException{
		
		int rowCnt=0; 
	
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			StringBuilder updateProject=new StringBuilder();
			updateProject
			.append("	update project 	")
			.append("	set prj_name='"+pmVO.getPrjName()+"' , startdate='"+pmVO.getStartdate()+"', enddate='"+pmVO.getEnddate()+"', prj_mgr='"+pmVO.getPrjMng()+"' 	")
			.append("	where prj_code='"+pmVO.getPrjCode()+"'	");
			
			pstmt=con.prepareStatement(updateProject.toString());
			//���ε� ������ �� �ֱ� 
			/*pstmt.setString(1, pmVO.getPrjName());
			pstmt.setString(2, pmVO.getStartdate());
			pstmt.setString(3, pmVO.getEnddate());
			pstmt.setString(4, pmVO.getPrjMng());
			pstmt.setString(5, pmVO.getPrjCode());*/
			
			
			//5.
			rowCnt=pstmt.executeUpdate();
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return rowCnt;
	}//updateProjectMng
	
	/**
	 * ������Ʈ�� �����ϴ� ��
	 * @param prjCode
	 * @return
	 * @throws SQLException
	 */
	public int deleteProjectMng( String prjCode ) throws SQLException{
		
		int rowCnt=0; 

		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			//3.
			con=getConn();
			//4.
			String deleteProject="delete from project where prj_code='"+prjCode+"' ";
			 
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
	}//deleteProjectMng
	
}//class
