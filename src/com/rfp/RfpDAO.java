package com.rfp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RfpDAO {
	
	DataSource ds;
	public RfpDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// insert(화면)
			public int insert(String rfpName, String dueDate, String type) {
				
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "INSERT INTO rfp(rfpName, dueDate,type)  VALUES (?, ? ,? )";
				
				try {
					conn = ds.getConnection();
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, rfpName);
					pstmt.setString(2, dueDate);
					pstmt.setString(3, type);
					
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
			
			public ArrayList<Rfp> getList(){
				
				ArrayList<Rfp> list = new ArrayList<Rfp>();
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "SELECT * FROM rfp ";
				
				try {
					conn = ds.getConnection();
					pstmt  = conn.prepareStatement(SQL);
					//pstmt.setString(1, userid);
					
					rs = pstmt.executeQuery();
					while (rs.next()) {
						Rfp rfp = new Rfp();
						rfp.setRfpid(rs.getInt(1));
						rfp.setRfpname(rs.getString(2));
						rfp.setDuedate(rs.getString(3));
						rfp.setType(rs.getString(4));
						list.add(rfp);
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
			
			public Rfp getRfp(int rfpID) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String SQL = "SELECT * FROM rfp "
						+" where rfpID = ?";
				
				try {
					conn = ds.getConnection();
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, rfpID);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						
						Rfp rfp = new Rfp();
						
						rfp.setRfpid(rs.getInt(1));
						rfp.setRfpname(rs.getString(2));
						rfp.setDuedate(rs.getString(3));
						rfp.setType(rs.getString(4));
						
						return rfp;
						
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
			
			
			public int update(int rfpID, String rfpName, String dueDate, String type) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "UPDATE rfp SET rfpName = ? , dueDate = ? , type = ? "
						+ " WHERE rfpID = ?";
						
				try {
					
					conn = ds.getConnection();
					pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, rfpName);
					pstmt.setString(2, dueDate);
					pstmt.setString(3, type);
					pstmt.setInt(4, rfpID);
					
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
			
			
			public int delete(int rfpID) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "Delete from rfp WHERE rfpID = ?";
				
				try {
					conn = ds.getConnection();
					pstmt = conn.prepareStatement(SQL);
					
					pstmt.setInt(1, rfpID);
					
					
					// 연결된 객체 모두 지우기
					RfpuserlistDAO aaa = new RfpuserlistDAO();
					aaa.deleteAlluserlist(rfpID);
					
					
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
