package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.pms.AuditHistory;
import com.pms.AuditGroupCount;

public class AuditHistoryDAO {

	DataSource ds;
	public AuditHistoryDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	
	
public ArrayList<AuditHistory> getList(String userid){
		
		ArrayList<AuditHistory> list = new ArrayList<AuditHistory>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM auditHistory WHERE userID = ? ORDER BY auditYearMonth DESC ";
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AuditHistory auditHistory = new AuditHistory();
				auditHistory.setAudithistoryid(rs.getInt(1));
				auditHistory.setProjectid(rs.getInt(2));
				auditHistory.setProjectname(rs.getString(3));
				auditHistory.setAudityearmonth(rs.getString(4));
				auditHistory.setAuditname(rs.getString(5));
				auditHistory.setMainclient(rs.getString(6));
				auditHistory.setMaindivision(rs.getString(7));
				auditHistory.setAuditfield(rs.getString(8));
				auditHistory.setAuditrole(rs.getString(9));
				auditHistory.setJoinrate(rs.getString(10));
				auditHistory.setAuditstartdate(rs.getString(11));
				auditHistory.setAuditenddate(rs.getString(12));
				list.add(auditHistory);
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
	
public ArrayList<AuditHistory> likeSearchAuditorHistoryList(String search){
		
		ArrayList<AuditHistory> list = new ArrayList<AuditHistory>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT b.userName,a.auditHistoryID,a.auditYearMonth,a.auditName,a.mainClient,a.mainDivision,a.auditField,a.auditRole,a.joinRate, a.auditStartDate, a.auditEndDate"
				+"	FROM auditHistory a left outer join user b"
				+" on a.userid = b.userid"
				+" where a.auditName like ?";
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AuditHistory auditHistory = new AuditHistory();
				auditHistory.setUsername(rs.getString(1));
				auditHistory.setAudithistoryid(rs.getInt(2));
				//auditHistory.setProjectid(rs.getInt(2));
				//auditHistory.setProjectname(rs.getString(3));
				auditHistory.setAudityearmonth(rs.getString(3));
				auditHistory.setAuditname(rs.getString(4));
				auditHistory.setMainclient(rs.getString(5));
				auditHistory.setMaindivision(rs.getString(6));
				auditHistory.setAuditfield(rs.getString(7));
				auditHistory.setAuditrole(rs.getString(8));
				auditHistory.setJoinrate(rs.getString(9));
				auditHistory.setAuditstartdate(rs.getString(10));
				auditHistory.setAuditenddate(rs.getString(11));
				list.add(auditHistory);
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
	
	
	
	
	
public ArrayList<AuditGroupCount> getAuditFieldGroupList(String userid){
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String SQL = " select auditField, count(auditHistoryID) as count from auditHistory "
			+ " where userID = ? "
			+ " group BY auditField " ;
			
	ArrayList<AuditGroupCount> list = new ArrayList<AuditGroupCount>();
	
	try {
		
		conn = ds.getConnection();
		pstmt  = conn.prepareStatement(SQL);
		pstmt.setString(1, userid);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			AuditGroupCount  auditGroupCount = new AuditGroupCount();
			auditGroupCount.setAuditField(rs.getString(1));
			auditGroupCount.setCount(rs.getString(2));

			list.add(auditGroupCount);
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


//[ 특수문자 처리가 필요함..
public String getAuditFieldGroupJSON(String userid) {
	if(userid == null) userid="";
	StringBuffer result = new StringBuffer("");
	ArrayList<AuditGroupCount> auditGroupCount = this.getAuditFieldGroupList(userid);
	for(int i=0; i<auditGroupCount.size(); i++) {
		result.append("[\"" +auditGroupCount.get(i).getAuditField() + "\",");
		result.append( auditGroupCount.get(i).getCount() + ",\"white blue\"]");
		
		//마지막 줄 처리 
		if(auditGroupCount.size() > (i+1)) { result.append(",");}
		
	}
	return result.toString();
}



// insert(엑셀)
	public int insertExcel(String userID, String auditYearMonth, String auditName, String mainClient,String mainDivision, String auditField, String auditRole, String joinRate) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO auditHistory(userID, auditYearMonth,auditName,mainClient,mainDivision,auditField,auditRole,joinRate)  VALUES (?, ? ,?, ?, ?, ?,?,? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, auditYearMonth);
			pstmt.setString(3, auditName);
			pstmt.setString(4, mainClient);
			pstmt.setString(5, mainDivision);
			pstmt.setString(6, auditField);
			pstmt.setString(7, auditRole);
			pstmt.setString(8, joinRate);
			
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
	
	
	// insert(화면)
		public int insert(String userID, String auditYearMonth, String auditName, String mainClient,String mainDivision, String auditField, String auditRole, String joinRate,String auditStartDate, String auditEndDate) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "INSERT INTO auditHistory(userID, auditYearMonth,auditName,mainClient,mainDivision,auditField,auditRole,joinRate,auditStartDate,auditEndDate)  VALUES (?, ? ,?, ?, ?, ?,?,?,?,? )";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				pstmt.setString(2, auditYearMonth);
				pstmt.setString(3, auditName);
				pstmt.setString(4, mainClient);
				pstmt.setString(5, mainDivision);
				pstmt.setString(6, auditField);
				pstmt.setString(7, auditRole);
				pstmt.setString(8, joinRate);
				pstmt.setString(9, auditStartDate);
				pstmt.setString(10, auditEndDate);
				
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
	
	
	
	public AuditHistory getAuditHistory(int auditHistoryID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT b.userName,a.auditHistoryID,a.auditYearMonth,a.auditName,a.mainClient,a.mainDivision,a.auditField,a.auditRole,a.joinRate,a.userID ,a.auditStartDate,a.auditEndDate "
				+"	FROM auditHistory a left outer join user b"
				+" on a.userID = b.userID"
				+" where a.auditHistoryID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, auditHistoryID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				AuditHistory auditHistory = new AuditHistory();
				auditHistory.setUsername(rs.getString(1));
				auditHistory.setAudithistoryid(rs.getInt(2));
				auditHistory.setAudityearmonth(rs.getString(3));
				auditHistory.setAuditname(rs.getString(4));
				auditHistory.setMainclient(rs.getString(5));
				auditHistory.setMaindivision(rs.getString(6));
				auditHistory.setAuditfield(rs.getString(7));
				auditHistory.setAuditrole(rs.getString(8));
				auditHistory.setJoinrate(rs.getString(9));
				auditHistory.setUserid(rs.getString(10));
				auditHistory.setAuditstartdate(rs.getString(11));
				auditHistory.setAuditenddate(rs.getString(12));
				
				return auditHistory;
				
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
	
	public int update(int auditHistoryID, String auditYearMonth, String auditName, String mainClient,String mainDivision, String auditField, String auditRole, String joinRate,String auditStartDate, String auditEndDate ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE auditHistory SET auditYearMonth = ? , auditName = ? , mainClient = ?, mainDivision = ?, auditField = ?, auditRole= ?, joinRate =?,auditStartDate=?, auditEndDate=?  "
				+ " WHERE auditHistoryID = ?";
				
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, auditYearMonth);
			pstmt.setString(2, auditName);
			pstmt.setString(3, mainClient);
			pstmt.setString(4, mainDivision);
			pstmt.setString(5, auditField);
			pstmt.setString(6, auditRole);
			pstmt.setString(7, joinRate);
			pstmt.setString(8, auditStartDate);
			pstmt.setString(9, auditEndDate);
			
			pstmt.setInt(10, auditHistoryID);
			
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
	
	
	public int delete(int auditHistoryID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from auditHistory WHERE auditHistoryID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, auditHistoryID);
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
