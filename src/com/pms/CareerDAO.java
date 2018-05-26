package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.pms.Career;

public class CareerDAO {

	DataSource ds;
	public CareerDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
public ArrayList<Career> getList( String userid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM career WHERE userid = ? ORDER BY period DESC ";
		ArrayList<Career> list = new ArrayList<Career>();
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Career career = new Career();
				
				career.setCareerid(rs.getInt(1));
				career.setUserid(rs.getString(2));
				career.setPeriod(rs.getString(3));
				career.setCareerdesc(rs.getString(4));
				career.setTask(rs.getString(5));
				career.setSimilarcareer(rs.getString(6));
				
				list.add(career);
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
	public int insertExcel(String userID, String period, String careerDesc, String task,String similarCareer) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "INSERT INTO career(userID, period ,careerDesc,task,similarCareer)  VALUES (?, ? ,?, ?, ? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, period);
			pstmt.setString(3, careerDesc);
			pstmt.setString(4, task);
			pstmt.setString(5, similarCareer);
			
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
	
	
	public Career getCareer(int careerID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT a.careerID,a.userID,a.period, a.careerDesc,a.task,a.similarCareer "
				+"	FROM career a left outer join user b"
				+" on a.userID = b.userID"
				+" where a.careerID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, careerID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				Career career = new Career();
				career.setCareerid(rs.getInt(1));
				career.setUserid(rs.getString(2));
				career.setPeriod(rs.getString(3));
				career.setCareerdesc(rs.getString(4));
				career.setTask(rs.getString(5));
				career.setSimilarcareer(rs.getString(6));
				
				return career;
				
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
	
	public int update(int careerID, String careerdesc, String period, String task,String similarcareer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE career SET careerDesc = ? , period = ? , task = ?, similarCareer = ? "
				+ " WHERE careerID = ?";
				
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, careerdesc);
			pstmt.setString(2, period);
			pstmt.setString(3, task);
			pstmt.setString(4, similarcareer);
			pstmt.setInt(5, careerID);
			
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
	
	
	public int delete(int careerID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from career WHERE careerID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, careerID);
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
