package com.secondproject.main.dao;

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

import com.secondproject.main.vo.MainVO;
import com.secondproject.main.vo.ProjectMgrVO;

public class MainDAO {
	
	private static MainDAO main_dao;

	private MainDAO() {

	}

	public static MainDAO getInstance() {
		if (main_dao == null) {
			main_dao = new MainDAO();
		}
		return main_dao;
	}

	public Connection getConn() throws SQLException {
		Connection con = null;

		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/team_dbcp");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public List<MainVO> selectPro(int nowYear, int nowMonth, String prj_code) throws SQLException {
		List<MainVO> list = new ArrayList<MainVO>();
		MainVO maVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String like = String.valueOf(nowYear)+"0"+String.valueOf(nowMonth)+"%";
		
		try {
			con = getConn();
			StringBuilder selectProcess = new StringBuilder();
			selectProcess
			.append("	select process_code, prj_code, process_name, start_date, complete_date 	")
			.append("	from prj_process	")
			.append("	where start_date like '"+like+"'	")
			.append("	and prj_code = '"+prj_code+"'	");
			
			pstmt = con.prepareStatement(selectProcess.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				maVO = new MainVO(rs.getString("process_code"), rs.getString("prj_code"), rs.getString("process_name"), 
						rs.getString("start_date"), rs.getString("complete_date"));
				list.add(maVO);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		}
		return list;
	}
	public List<ProjectMgrVO> proOtion(int nowYear, int nowMonth) throws SQLException{
		List<ProjectMgrVO> list = new ArrayList<ProjectMgrVO>();
		ProjectMgrVO pmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String like = String.valueOf(nowYear)+"0"+String.valueOf(nowMonth)+"%";
		try {
			con = getConn();
			StringBuilder selectOption = new StringBuilder();
			selectOption
			.append("	select distinct p.prj_code, p.prj_name 	")
			.append("	from prj_process pj, project p	")
			.append("	where pj.prj_code = p.prj_code 	")
			.append("	and start_date like ?	");
			
			pstmt = con.prepareStatement(selectOption.toString());
			pstmt.setString(1, like);
			
			rs = pstmt.executeQuery();

			while(rs.next()) {
				pmVO = new ProjectMgrVO(rs.getString("prj_code"), rs.getString("prj_name"));
				list.add(pmVO);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		}
		return list;
	}
	
}
