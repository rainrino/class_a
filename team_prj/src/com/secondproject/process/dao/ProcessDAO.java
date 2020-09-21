package com.secondproject.process.dao;

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

import com.secondproject.process.vo.InsertProcesssVO;
import com.secondproject.process.vo.ProjectVO;
import com.secondproject.process.vo.SelectProcessVO;
import com.secondproject.process.vo.UpdateProcessVO;

/**
 * @author sist27
 *
 */
public class ProcessDAO {
	
	private static ProcessDAO pDao;
	
	private ProcessDAO() {
	}
	
	public static ProcessDAO getInstance() {
		
		if(pDao == null) {
			pDao = new ProcessDAO();
		}//end if
		
		return pDao;
	}//getInstance
	
	
	private Connection getConn() throws SQLException{
		
		Connection con = null;
		
		try {
			//1. JNDI ��밴ü ����
			Context ctx = new InitialContext();
			
			//2. DBCP���� DB���� ��ü ���
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/team_dbcp");

			//3. Connection ���
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}//end catch
		
		return con;
	}//getConn
	
	
	/**
	 * �������� ����Ʈ ��� �����ִ� ��
	 * @return
	 * @throws SQLException
	 */
	public List<SelectProcessVO> selectAllProcess() throws SQLException{
		
		List<SelectProcessVO> list = new ArrayList<SelectProcessVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//3.Connection ���
			con = getConn();
			
			//4.������ ������ü ���
			StringBuilder selectAllProcess = new StringBuilder();
			selectAllProcess
			.append("	select prj.prj_name, prc.prj_mgr, d.dept_name, process_name, start_date, complete_date, working_days, note, process_code	")
			.append("	from prj_process prc, dept_table d, project prj	")
			.append("	where d.dept_no=prc.dept_no and prc.prj_code=prj.prj_code	")
			.append("	order by prj.prj_code	");
			
			pstmt = con.prepareStatement(selectAllProcess.toString());
			
			//5.���� ���� �� ��� ���
			rs = pstmt.executeQuery();
			
			//��ȸ�� �÷� ���� �����ϱ� ���� VO���� 
			SelectProcessVO spVO = null;
			
			while( rs.next()) {
				//��ȸ�� �� ���� VO���� 
				spVO = new SelectProcessVO(rs.getString("prj_name"), rs.getString("prj_mgr"), rs.getString("dept_name"),
						rs.getString("process_name"), rs.getString("start_date"), rs.getString("complete_date"),rs.getInt("working_days"), 
						 rs.getString("note"), rs.getString("process_code"));
				if(spVO.getNote() == null) {
					spVO.setNote("");
				}
				//������ ������ VO�� list�� �߰� 
				list.add(spVO);
				
			}//end while
			
		} finally {
			//6.���� ����
			if( rs != null ) { rs.close(); }
			if( pstmt != null ) { pstmt.close(); }
			if( con != null ) { con.close(); }
		}//finally
		
		return list;
		
	}//selectAllProcess

	
	/**
	 * select option�� ������Ʈ���� �����ִ� ��
	 * @return listPrjName
	 * @throws SQLException
	 */
	public List<ProjectVO> selectPrjName() throws SQLException{

		List<ProjectVO> listPrjName = new ArrayList<ProjectVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			//3.
			con = getConn();
			
			//4.
			String selectProjectName = "select prj_name, trim(prj_code) prj_code from project order by prj_code";

			pstmt = con.prepareStatement(selectProjectName);

			//5.
			rs=pstmt.executeQuery();
			
			//��ȸ�� �÷� ���� �����ϱ� ���� VO���� 
			ProjectVO projectVO = null;
			
			while( rs.next()){
				//��ȸ�� �� ���� VO���� 
				projectVO = new ProjectVO(rs.getString("prj_name"), rs.getString("prj_code"));
				//������ ������ VO�� list�� �߰� 
				listPrjName.add(projectVO);
			}//end while

		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 

		return listPrjName;

	}//selectPrjName
	
	
	/**
	 * ��������������� select�� ������Ʈ������ ��ȸ�ϴ� �� 
	 * @return listPrjName
	 * @throws SQLException
	 */
	public List<SelectProcessVO> selectAllPrjName(String prj_code) throws SQLException{
		
		List<SelectProcessVO> listPrjName = new ArrayList<SelectProcessVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			//3.
			con = getConn();
			
			//4.
			StringBuilder selectAllPrjName = new StringBuilder();
			selectAllPrjName
			.append("	select prj.prj_name, prc.prj_mgr, d.dept_name, process_name, start_date, complete_date, working_days, note, process_code	")
			.append("	from prj_process prc, dept_table d, project prj	")
			.append("	where d.dept_no=prc.dept_no and prc.prj_code=prj.prj_code	");
			
			if(prj_code != "all") { //������Ʈ ��ȸ �� prj_code�� all�� �ƴ� �� 
 				selectAllPrjName.append("	and trim(prj.prj_code)=trim('")
				.append(prj_code)
				.append("')	");
			}//end if 

			selectAllPrjName.append("	order by prj.prj_code	");	
			
			pstmt = con.prepareStatement(selectAllPrjName.toString());
			
			//5.
			rs = pstmt.executeQuery();
			

			//��ȸ�� �÷� ���� �����ϱ� ���� VO���� 
			SelectProcessVO spVO = null;
			
			while( rs.next()) {
				//��ȸ�� �� ���� VO���� 
				spVO = new SelectProcessVO(rs.getString("prj_name"), rs.getString("prj_mgr"), rs.getString("dept_name"),
						rs.getString("process_name"), rs.getString("start_date"), rs.getString("complete_date"),rs.getInt("working_days"), 
						 rs.getString("note"), rs.getString("process_code"));
				if(spVO.getNote() == null) {
					spVO.setNote("");
				}
				//������ ������ VO�� list�� �߰� 
				listPrjName.add(spVO);
				
			}//end while
			
		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return listPrjName;
		
	}//selectAllPrjName

	
	/**
	 * select option�� ������Ʈ ����ڸ� �����ִ� ��
	 * @return listPrjMgr
	 * @throws SQLException
	 */
	public List<String> selectPrjMgr()throws SQLException{
		
		List<String> listPrjMgr = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			//3.
			con = getConn();
			
			//4.
			String selectPrjMgr = "select distinct prj_mgr from project";
			
			pstmt = con.prepareStatement(selectPrjMgr);
			
			//5.
			rs=pstmt.executeQuery();
			
			while( rs.next()){
				listPrjMgr.add(rs.getString("prj_mgr"));
			}//end while
			
		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return listPrjMgr;
		
	}//selectPrjMgr

	
	/**
	 * select option�� ���μ��� �����ִ� ��
	 * @return listDeptName
	 * @throws SQLException
	 */
	public List<String> selectDeptName()throws SQLException{
		
		List<String> listDeptName = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			//3.
			con = getConn();
			
			//4.
			String selectDeptName = "select dept_name from dept_table";
			
			pstmt = con.prepareStatement(selectDeptName);
			
			//5.
			rs=pstmt.executeQuery();
			
			while( rs.next()){
				listDeptName.add(rs.getString("dept_name"));
			}//end while
			
		}finally {
			//6.
			if( rs != null) {rs.close();} //end if 
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return listDeptName;
		
	}//selectDeptName
	
	
	/**
	 * ���� �߰��ϴ� ��
	 * @param ipVO
	 * @throws SQLException
	 */
	public int insertProcess(InsertProcesssVO ipVO) throws SQLException{
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int cnt = 0;
		
		try {
			//3.
			con = getConn();
			//4.
			StringBuilder insertProcess = new StringBuilder();
			insertProcess
			.append("	insert into prj_process	")
			.append("	(process_code, prj_code, prj_mgr, dept_no, process_name, start_date, complete_date, working_days, note)	")
			.append("	values('prc_'||pro_seq.nextval,	")
			.append("	(select prj_code from project where prj_name= ?), ?,	")
			.append("	(select dept_no from dept_table where dept_name= ?), ?, ?, ?, ?, ?)	");
			
			pstmt = con.prepareStatement(insertProcess.toString());
			if(ipVO.getNote() == null) {
				ipVO.setNote("");
			}
			//���ε� ������ �� �ֱ�
			pstmt.setString(1, ipVO.getProjectName());
			pstmt.setString(2, ipVO.getProjectMgr());
			pstmt.setString(3, ipVO.getDeptName());
			pstmt.setString(4, ipVO.getProcessName());
			pstmt.setString(5, ipVO.getStart_date());
			pstmt.setString(6, ipVO.getComplete_date());
			pstmt.setInt(7, ipVO.getWorking_days());
			pstmt.setString(8, ipVO.getNote());

			//5.
			cnt = pstmt.executeUpdate();
			
		} finally {
			//6.
			if( pstmt != null ) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally
		
		return cnt;
		
	}//insertProcess
	
	
	/**
	 * ������ �����ϴ� ��
	 * @param ipVO
	 * @return rowCnt
	 * @throws SQLException
	 */

	public int updateProcess(UpdateProcessVO upVO) throws SQLException{
		
		int rowCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//3.Connection ���
			con = getConn();

			//4.
			StringBuilder updateProcess = new StringBuilder();
			updateProcess
			.append("	update prj_process	")
			.append("	set prj_code=(select prj_code from project where prj_name= ?),	")
			.append("	prj_mgr= ?,	")
			.append("	dept_no=(select dept_no from dept_table where dept_name= ?),	")
			.append("	process_name= ?, start_date= ?, complete_date= ?, working_days= ?, note= ?	")
			.append("	where process_code=(select process_code from prj_process pc, project p where (pc.prj_code = p.prj_code) and pc.process_name= ? and pc.prj_code=(select prj_code from project where prj_name= ?)) ");
			
			pstmt = con.prepareStatement(updateProcess.toString());
			System.out.println(updateProcess);
			System.out.println(upVO);
			//���ε� ������ �� �ֱ�
			pstmt.setString(1, upVO.getProjectName());
			pstmt.setString(2, upVO.getProjectMgr());
			pstmt.setString(3, upVO.getDeptName());
			pstmt.setString(4, upVO.getProcessName());
			pstmt.setString(5, upVO.getStart_date());
			pstmt.setString(6, upVO.getComplete_date());
			pstmt.setInt(7, upVO.getWorking_days());
			pstmt.setString(8, upVO.getNote());
			pstmt.setString(9, upVO.getProcessName());
			pstmt.setString(10, upVO.getOld_prj_name());

			//5.
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			if( pstmt != null ) { pstmt.close(); }
			if( con != null ) { con.close(); }
		}//finally
		
		return rowCnt;
		
	}//updateProcess
	
	
	/**
	 * ���� ����
	 * @param process_code
	 * @return rowCnt
	 * @throws SQLException
	 */
	public int deleteProcess(String process_code) throws SQLException{
		
		int rowCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//3.
			con = getConn();
			//4.
			String deleteProcess = "delete from prj_process where process_code=?";

			pstmt = con.prepareStatement(deleteProcess);
			
			//���ε� ������ �� �ֱ�
			pstmt.setString(1, process_code);
			
			//5.
			rowCnt = pstmt.executeUpdate();
			
		}finally {
			//6.
			if( pstmt != null) {pstmt.close();} //end if 
			if( con != null) {con.close();} //end if 
		}//end finally 
		
		return rowCnt;
		
	}//deleteProcess
	
}//class


