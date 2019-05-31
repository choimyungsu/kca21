package com.rfp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONValue;

public class RfpuserlistDAO {
	
	DataSource ds;
	public RfpuserlistDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// insert(화면)
	public int insert(Integer rfpID, String userID) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO rfpUserList(rfpID, userID)  VALUES (?, ? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rfpID);
			pstmt.setString(2, userID);
			
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
	
	
	public ArrayList<Rfpuserlist> getList(int rfpID){
		
		ArrayList<Rfpuserlist> list = new ArrayList<Rfpuserlist>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		/*String SQL = "SELECT * FROM rfpUserList "
		           +" where rfpID = ?";
		*/
		String SQL = " SELECT a.rfpUserListID,a.rfpID,a.userID,a.auditField,b.userName,b.auditNo,"
				+ " (select count(auditHistoryID) from auditHistory c where c.userID = a.userID ) cnt , "
				+ " (select sum(eduTime) from edu d where d.userID = a.userID ) eduTime  "
				+ "		FROM rfpUserList a left join user b "
				+ "		on a.userID = b.userID "
				+ "		where a.rfpID = ? ";
		
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setInt(1, rfpID);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Rfpuserlist rfpuserlist = new Rfpuserlist();
				rfpuserlist.setRfpuserlistid(rs.getInt(1));
				rfpuserlist.setRfpid(rs.getInt(2));
				rfpuserlist.setUserid(rs.getString(3));
				rfpuserlist.setAuditfield(rs.getString(4));
				rfpuserlist.setUsername(rs.getString(5));
				rfpuserlist.setAuditno(rs.getString(6));
				rfpuserlist.setCnt(rs.getString(7));
				rfpuserlist.setEduTime(rs.getString(8));
				
				list.add(rfpuserlist);
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
	
	
	
public String getListJSON(int rfpID){
		
		ArrayList<Rfpuserlist> list = new ArrayList<Rfpuserlist>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String jsonData="";

		String SQL = " SELECT a.rfpUserListID,a.rfpID,a.userID,a.auditField,b.userName,b.auditNo,"
				+ " (select count(auditHistoryID) from auditHistory c where c.userID = a.userID ) cnt , "
				+ " (select sum(eduTime) from edu d where d.userID = a.userID ) eduTime  "
				+ "		FROM rfpUserList a left join user b "
				+ "		on a.userID = b.userID "
				+ "		where a.rfpID = ? ";
		
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setInt(1, rfpID);
			
			rs = pstmt.executeQuery();
			jsonData = getJSONFromResultSet(rs,"gridData");// 공통함수 호출
			
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
		return jsonData;//
	}
	
	// Resultset을 받아서 json으로 반환하기 
	public String getJSONFromResultSet(ResultSet rs,String keyName) {
	    Map json = new HashMap(); 
	    List list = new ArrayList();
	    if(rs!=null)
	    {
	        try {
	            ResultSetMetaData metaData = rs.getMetaData();
	            while(rs.next())
	            {
	                Map<String,Object> columnMap = new HashMap<String, Object>();
	                for(int columnIndex=1;columnIndex<=metaData.getColumnCount();columnIndex++)
	                {
	                    if(rs.getString(metaData.getColumnName(columnIndex))!=null)
	                        columnMap.put(metaData.getColumnLabel(columnIndex),     rs.getString(metaData.getColumnName(columnIndex)));
	                    else
	                        columnMap.put(metaData.getColumnLabel(columnIndex), "");
	                }
	                list.add(columnMap);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        json.put(keyName, list);
	     }
	     return JSONValue.toJSONString(json);
	}
	
	
	public int update(int rfpUserListID, String auditField) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE rfpUserList SET auditField = ?  "
				+ " WHERE rfpUserListID = ?";
				
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, auditField);
			pstmt.setInt(2, rfpUserListID);
			
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
	
	
	
	
	public int delete(int rfpuserlistID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from rfpUserList WHERE rfpUserListID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, rfpuserlistID);
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
	
	
	public int deleteAlluserlist(int rfpID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from rfpUserList WHERE rfpID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, rfpID);
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
