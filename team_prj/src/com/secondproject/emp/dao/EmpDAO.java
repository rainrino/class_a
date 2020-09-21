package com.secondproject.emp.dao;

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

import com.secondproject.emp.vo.DeptVO;
import com.secondproject.emp.vo.EmpAddVO;
import com.secondproject.emp.vo.EmpDelVO;
import com.secondproject.emp.vo.EmpOnlyVO;
import com.secondproject.emp.vo.EmpSelectVO;
import com.secondproject.emp.vo.PositionVO;

public class EmpDAO {
	private static EmpDAO emp_dao;

	private EmpDAO() {

	}

	public static EmpDAO getInstance() {
		if (emp_dao == null) {
			emp_dao = new EmpDAO();
		}
		return emp_dao;
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
	
	public List<EmpSelectVO> selectedAllUser() throws SQLException {
		List<EmpSelectVO> list = new ArrayList<EmpSelectVO>();
		EmpSelectVO euVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			StringBuilder selectedEmpUser = new StringBuilder();
			selectedEmpUser.append("	select emp_no, emp_name, dept_name, p.position, email, to_char(hiredate,'yyyyMMdd')hiredate 	")
					.append("	from emp e, position p	")
					.append("	where p.position is not null and dept_name is not null	")
					.append("	and e.position = p.position	")
					.append("	order	by p.position_no asc	");

			pstmt = con.prepareStatement(selectedEmpUser.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if(rs.getString("position") == "마스터") {
					continue;
				}
				euVO = new EmpSelectVO(rs.getString("emp_no"), rs.getString("emp_name"), rs.getString("position"),
						rs.getString("dept_name"), rs.getString("email"), rs.getString("hiredate"));
				list.add(euVO);
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

	public List<EmpSelectVO> selectedWaitingUser() throws SQLException {
		List<EmpSelectVO> list = new ArrayList<EmpSelectVO>();
		EmpSelectVO euVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			StringBuilder selectedEmpUser = new StringBuilder();
			selectedEmpUser.append("	select emp_no, emp_name, dept_name, position, email, to_char(hiredate,'yyyyMMdd')hiredate 	")
					.append("	from emp	").append("	where position is null	");

			pstmt = con.prepareStatement(selectedEmpUser.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if(rs.getString("position") == "마스터") {
					continue;
				}
				euVO = new EmpSelectVO(rs.getString("emp_no"), rs.getString("emp_name"), rs.getString("position"),
						rs.getString("dept_name"), rs.getString("email"), rs.getString("hiredate"));
				list.add(euVO);
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

	public List<PositionVO> positionList() throws SQLException {
		List<PositionVO> list = new ArrayList<PositionVO>();
		PositionVO poVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			StringBuilder selectedPosition = new StringBuilder();
			selectedPosition
			.append("	select position, position_no 	")
			.append("	from position	");

			pstmt = con.prepareStatement(selectedPosition.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				poVO = new PositionVO(rs.getString("position"),rs.getString("position_no"));
				list.add(poVO);
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
	public List<DeptVO> deptList() throws SQLException {
		List<DeptVO> list = new ArrayList<DeptVO>();
		DeptVO deVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConn();
			StringBuilder selectedDept= new StringBuilder();
			selectedDept
			.append("	select dept_name, dept_no 	")
			.append("	from dept_table	");
			
			pstmt = con.prepareStatement(selectedDept.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				deVO = new DeptVO(rs.getString("dept_name"),rs.getInt("dept_no"));
				list.add(deVO);
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

	public List<EmpOnlyVO> selectOnlyEMP(DeptVO deVO) throws SQLException {
		List<EmpOnlyVO> list = new ArrayList<EmpOnlyVO>();
		EmpOnlyVO eoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			StringBuilder selectedEmpUser = new StringBuilder();
			selectedEmpUser
			.append("select e.emp_no, e.emp_name, p.position, p.position_no, e.dept_name, e.email, to_char(e.hiredate,'yyyyMMdd')hiredate ")
			.append("from emp e, position p ")
			.append("where e.position = p.position ")
			.append("and p.position is not null ")
			.append("and e.dept_name is not null ")
			.append("and p.position not in (select position from position where position = '마스터') ");
			
			
			if(deVO.getDept_name()!=null && !"".equals(deVO.getDept_name()) && !"전체보기".equals(deVO.getDept_name())) {
				selectedEmpUser.append("and e.dept_name = ? ");
			}
			selectedEmpUser.append("order by  p.position_no asc, e.emp_no asc ");

			pstmt = con.prepareStatement(selectedEmpUser.toString());
			
			if(deVO.getDept_name() != null && !"".equals(deVO.getDept_name()) && !"전체보기".equals(deVO.getDept_name())) {
				pstmt.setString(1, deVO.getDept_name());
			}
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if(rs.getString("position") == "마스터") {
					continue;
				}
				eoVO = new EmpOnlyVO(rs.getString("emp_no"), rs.getString("emp_name"), rs.getString("position"),
						rs.getString("position_no"), rs.getString("dept_name"), rs.getString("email"), rs.getString("hiredate"));
				list.add(eoVO);
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
	
	public int updateUser(EmpAddVO eaVO) throws SQLException {
		int rowCount = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConn();
			StringBuilder updateUser = new StringBuilder();
			updateUser.append("	update emp	")
			.append("	set dept_name=(select dept_name from dept_table where dept_name=?),	")
			.append("	dept_no=(select dept_no from dept_table where dept_name=?), position=?	")
			.append("	where email=?	");
			pstmt = con.prepareStatement(updateUser.toString());

			pstmt.setString(1, eaVO.getDeptName());
			pstmt.setString(2, eaVO.getDeptName());
			pstmt.setString(3, eaVO.getPosition());
			pstmt.setString(4, eaVO.getEmail());

			rowCount = pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		}

		return rowCount;
	}

	public int deleteUser(EmpDelVO edVO) throws SQLException {

		int rowCount = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConn();
			StringBuilder deleteUser = new StringBuilder();
			deleteUser.append("	delete from emp	").append("	where email=?	");
			pstmt = con.prepareStatement(deleteUser.toString());

			pstmt.setString(1, edVO.getEmail());

			rowCount = pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		}

		return rowCount;
	}
}
