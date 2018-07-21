package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.user.UserDAO;

public class EduDAO {

	
	DataSource ds;
	public EduDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
public ArrayList<Edu> getList( String userid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT eduID,userID,eduDesc,round(eduTime),eduPeriod,eduAgency FROM edu WHERE userid = ? ORDER BY eduPeriod DESC ";
		ArrayList<Edu> list = new ArrayList<Edu>();
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Edu edu = new Edu();
				
				edu.setEduid(rs.getInt(1));
				edu.setUserid(rs.getString(2));
				edu.setEdudesc(rs.getString(3));
				edu.setEdutime(rs.getString(4));
				edu.setEduperiod(rs.getString(5));
				edu.setEduagency(rs.getString(6));
				
				list.add(edu);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;//
	}


//insert(엑셀)
	public int insertExcel(String userID, String eduDesc, String eduTime, String eduPeriod, String eduAgency) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "INSERT INTO edu(userID, eduDesc ,eduTime,eduPeriod, eduAgency)  VALUES (?, ? ,?, ?, ? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, eduDesc);
			pstmt.setString(3, eduTime);
			pstmt.setString(4, eduPeriod);
			pstmt.setString(5, eduAgency);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;//데이터베이스 오류
	}
	
	
	public Edu getEdu(int eduID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT a.eduID,a.userID,a.eduDesc, round(a.eduTime),a.eduPeriod,a.eduAgency "
				+"	FROM edu a left outer join user b"
				+" on a.userID = b.userID"
				+" where a.eduID = ?";
		
		
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, eduID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				Edu edu = new Edu();
				edu.setEduid(rs.getInt(1));
				edu.setUserid(rs.getString(2));
				edu.setEdudesc(rs.getString(3));
				edu.setEdutime(rs.getString(4));
				edu.setEduperiod(rs.getString(5));
				edu.setEduagency(rs.getString(6));
				
				return edu;
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null;//
	}
	
	public int update(int eduID, String eduDesc, String eduTime, String eduPeriod,String eduAgency, String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE edu SET eduDesc = ? , eduTime = ? , eduPeriod = ?, eduAgency = ? "
				+ " WHERE eduID = ?";
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, eduDesc);
			pstmt.setString(2, eduTime);
			pstmt.setString(3, eduPeriod);
			pstmt.setString(4, eduAgency);
			pstmt.setInt(5, eduID);
			
			return  pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				UserDAO userDAO = new UserDAO();
				userDAO.update(userID);// user 업데이트 날짜 변경
				
				if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;//데이터베이스 오류
		
	}
	
	
	public int delete(int eduID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from edu WHERE eduID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, eduID);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;//데이터베이스 오류
		
	}
	
	
	
	
	
}
