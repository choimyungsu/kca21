package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.pms.Certi;

public class CertiDAO {

	DataSource ds;
	public CertiDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
public ArrayList<Certi> getList(String userid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM certi WHERE userid = ? ORDER BY certiID DESC";
		ArrayList<Certi> list = new ArrayList<Certi>();
		
		try {
			
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Certi certi = new Certi();
				
				certi.setCertiid(rs.getInt(1));
				certi.setUserid(rs.getString(2));
				certi.setCertiname(rs.getString(3));
				certi.setIssuer(rs.getString(4));
				certi.setCertidivision(rs.getString(5));
				certi.setCertifield(rs.getString(6));
				certi.setIssuedate(rs.getString(7));
				
				list.add(certi);
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
	public int insertExcel(String userID, String certiName, String issuer, String certiDivision,String certiField) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "INSERT INTO certi(userID, certiName ,issuer,certiDivision,certiField)  VALUES (?, ? ,?, ?, ? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, certiName);
			pstmt.setString(3, issuer);
			pstmt.setString(4, certiDivision);
			pstmt.setString(5, certiField);
			
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
	
	//insert
		public int insert(String userID, String certiName, String issuer, String certiDivision,String certiField, String issueDate) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String SQL = "INSERT INTO certi(userID, certiName ,issuer,certiDivision,certiField,issueDate)  VALUES (?, ? ,?, ?, ?, ? )";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				pstmt.setString(2, certiName);
				pstmt.setString(3, issuer);
				pstmt.setString(4, certiDivision);
				pstmt.setString(5, certiField);
				pstmt.setString(6, issueDate);
				
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
	
	public Certi getCerti(int certiID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT a.certiID,a.userID,a.certiName, a.issuer,a.certiDivision,a.certiField,a.issueDate "
				+"	FROM certi a left outer join user b"
				+" on a.userID = b.userID"
				+" where a.certiID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, certiID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				Certi certi = new Certi();
				certi.setCertiid(rs.getInt(1));
				certi.setUserid(rs.getString(2));
				certi.setCertiname(rs.getString(3));
				certi.setIssuer(rs.getString(4));
				certi.setCertidivision(rs.getString(5));
				certi.setCertifield(rs.getString(6));
				certi.setIssuedate(rs.getString(7));
				
				return certi;
				
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
	
	public int update(int certiID, String certiName, String issuer, String certiDivision,String certiField, String issueDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE certi SET certiName = ? , issuer = ? , certiDivision = ?, certiField = ?, issueDate = ? "
				+ " WHERE certiID = ?";
		
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, certiName);
			pstmt.setString(2, issuer);
			pstmt.setString(3, certiDivision);
			pstmt.setString(4, certiField);
			pstmt.setString(5, issueDate);
			
			pstmt.setInt(6, certiID);
			
			return  pstmt.executeUpdate();
			
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
	
	
	public int delete(int certiID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from certi WHERE certiID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, certiID);
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
