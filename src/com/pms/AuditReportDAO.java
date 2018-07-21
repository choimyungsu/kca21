package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.pms.AuditReport;
import com.util.Util;

public class AuditReportDAO {
	
	DataSource ds;
	public AuditReportDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

	
	public int getNext() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT auditReportID from auditReport ORDER BY auditReportID DESC";
		try {
			conn = ds.getConnection(); 
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 첫번째 게시물인 경우
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

	
	//페이징 처리를 위한 함수
		public boolean nextPage(int pageNumber) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM auditReport WHERE auditReportID < ?  ORDER BY auditReportID DESC LIMIT 20";
			
			try {
				conn = ds.getConnection(); 
				pstmt = conn.prepareStatement(SQL);
				int aaa = getNext() - (pageNumber -1) * 20;
				//System.out.println("nextPage: 인자값은" + aaa);
				pstmt.setInt(1, aaa);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
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
			return false;//
		}
	
public ArrayList<AuditReport> getList(int pageNumber){
		
		ArrayList<AuditReport> list = new ArrayList<AuditReport>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM auditReport WHERE auditReportID < ?  ORDER BY auditReportID DESC LIMIT 20";
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 20);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
					
				AuditReport auditReport = new AuditReport();
				
				auditReport.setAuditreportid(rs.getInt(1));
				auditReport.setProjectid(rs.getInt(2));
				auditReport.setSeq(rs.getString(3));
				auditReport.setAuditname(rs.getString(4));
				auditReport.setPlaceauditdate(rs.getString(5));
				auditReport.setAuditdate(rs.getString(6));
				auditReport.setAuditors(rs.getString(7));
				auditReport.setAuditfield(rs.getString(8));
				auditReport.setContractauditdate(rs.getString(9));
				auditReport.setMainclient(rs.getString(10));
				auditReport.setDevelopcompany(rs.getString(11));
				auditReport.setAuditcost(rs.getString(12));
				auditReport.setDevelopcost(rs.getString(13));
				auditReport.setDevelopmethod(rs.getString(14));
				auditReport.setBizoverview(rs.getString(15));
				auditReport.setBizscope(rs.getString(16));
				auditReport.setBizperiod(rs.getString(17));
				auditReport.setMaintechnology(rs.getString(18));
				auditReport.setAuditavailable(rs.getInt(19));
				auditReport.setAuditstartdate(rs.getString(20));
				auditReport.setAuditenddate(rs.getString(21));
				auditReport.setMainauditor(rs.getString(22));
				auditReport.setAuditstep(rs.getString(23));
				auditReport.setCreatedate(rs.getString(24));
				auditReport.setUpdatedate(rs.getString(25));
				
				list.add(auditReport);
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
	
public ArrayList<AuditReport> likeSearchAuditorReport(String search){
		
		ArrayList<AuditReport> list = new ArrayList<AuditReport>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 쿼리문 바꾸기.
		String SQL = "SELECT * "
				+"	FROM auditReport "
				+" where auditName like ? "
				+"	or mainClient like  ? "
				+"	or bizOverview like  ? "
				+"	or bizScope like  ? "
				+"	or mainTechnology like  ? " ;
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			pstmt.setString(3, "%"+search+"%");
			pstmt.setString(4, "%"+search+"%");
			pstmt.setString(5, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AuditReport auditReport = new AuditReport();
				
				auditReport.setAuditreportid(rs.getInt(1));
				auditReport.setProjectid(rs.getInt(2));
				auditReport.setSeq(rs.getString(3));
				auditReport.setAuditname(rs.getString(4));
				auditReport.setPlaceauditdate(rs.getString(5));
				auditReport.setAuditdate(rs.getString(6));
				auditReport.setAuditors(rs.getString(7));
				auditReport.setAuditfield(rs.getString(8));
				auditReport.setContractauditdate(rs.getString(9));
				auditReport.setMainclient(rs.getString(10));
				auditReport.setDevelopcompany(rs.getString(11));
				auditReport.setAuditcost(rs.getString(12));
				auditReport.setDevelopcost(rs.getString(13));
				auditReport.setDevelopmethod(rs.getString(14));
				auditReport.setBizoverview(rs.getString(15));
				auditReport.setBizscope(rs.getString(16));
				auditReport.setBizperiod(rs.getString(17));
				auditReport.setMaintechnology(rs.getString(18));
				auditReport.setAuditavailable(rs.getInt(19));
				auditReport.setAuditstartdate(rs.getString(20));
				auditReport.setAuditenddate(rs.getString(21));
				auditReport.setMainauditor(rs.getString(22));
				auditReport.setAuditstep(rs.getString(23));
				auditReport.setCreatedate(rs.getString(24));
				auditReport.setUpdatedate(rs.getString(25));
				
				list.add(auditReport);
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

	
	
	// insert(화면)
		public int insert(AuditReport auditReport) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "INSERT INTO auditReport " + 
					"    (projectID, " + 
					"    seq, " + 
					"    auditName, " + 
					"    placeAuditDate, " + 
					"    auditDate, " + 
					"    auditors, " + 
					"    auditField, " + 
					"    contractAuditDate, " + 
					"    mainClient, " + 
					"    developCompany, " + 
					"    auditCost, " + 
					"    developCost, " + 
					"    developMethod, " + 
					"    bizOverview, " + 
					"    bizScope, " + 
					"    bizPeriod, " + 
					"    mainTechnology, " + 
					"    auditAvailable, " + 
					"    auditStartDate, " + 
					"    auditEndDate, " + 
					"    mainAuditor, " + 
					"    auditStep, " + 
					"    createDate, " + 
					"    updateDate)" + 
					" VALUES" + 
					"    ( ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?   )"; 
			try {
				Util util = new Util();
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, util.nullconvertInteger(auditReport.getProjectid()));
				pstmt.setString(2, util.nullconvertString(auditReport.getSeq()));
				pstmt.setString(3, util.nullconvertString(auditReport.getAuditname()));
				pstmt.setString(4, util.nullconvertString(auditReport.getPlaceauditdate()));
				pstmt.setString(5, util.nullconvertString(auditReport.getAuditdate()));
				pstmt.setString(6, util.nullconvertString(auditReport.getAuditors()));
				pstmt.setString(7, util.nullconvertString(auditReport.getAuditfield()));
				pstmt.setString(8, util.nullconvertString(auditReport.getContractauditdate()));
				pstmt.setString(9, util.nullconvertString(auditReport.getMainclient()));
				pstmt.setString(10, util.nullconvertString(auditReport.getDevelopcompany()));
				pstmt.setString(11, util.nullconvertString(auditReport.getAuditcost()));
				pstmt.setString(12, util.nullconvertString(auditReport.getDevelopcost()));
				pstmt.setString(13, util.nullconvertString(auditReport.getDevelopmethod()));
				pstmt.setString(14, util.nullconvertString(auditReport.getBizoverview()));
				pstmt.setString(15, util.nullconvertString(auditReport.getBizscope()));
				pstmt.setString(16, util.nullconvertString(auditReport.getBizperiod()));
				pstmt.setString(17, util.nullconvertString(auditReport.getMaintechnology()));
				pstmt.setInt(18, util.nullconvertInteger(auditReport.getAuditavailable()));
				pstmt.setString(19, util.nullconvertString(auditReport.getAuditstartdate()));
				pstmt.setString(20, util.nullconvertString(auditReport.getAuditenddate()));
				pstmt.setString(21, util.nullconvertString(auditReport.getMainauditor()));
				pstmt.setString(22, util.nullconvertString(auditReport.getAuditstep()));
				pstmt.setString(23, util.nullconvertString(auditReport.getCreatedate()));
				pstmt.setString(24, util.nullconvertString(auditReport.getUpdatedate()));
				
				
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
	
	
	
	public AuditReport getAuditReport(int auditReportID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT auditReportID, "
					+ "projectID, "
					+ "seq, "
					+ "auditName, "
					+ "placeAuditDate, "
					+ "auditDate, "
					+ "auditors, "
					+ "auditField, "
					+ "contractAuditDate, "
					+ "mainClient, "
					+ "developCompany, "
					+ "auditCost, "
					+ "developCost, "
					+ "developMethod, "
					+ "bizOverview, "
					+ "bizScope, "
					+ "bizPeriod, "
					+ "mainTechnology, "
					+ "auditAvailable, "  
					+ "auditStartDate, "
					+ "auditEndDate, "
					+ "mainAuditor, "
					+ "auditStep, "
					+ "createDate, "
					+ "updateDate " 
					+ "FROM auditReport where auditReportID = ? ";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, auditReportID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				AuditReport auditReport = new AuditReport();
				
				auditReport.setAuditreportid(rs.getInt(1));
				auditReport.setProjectid(rs.getInt(2));
				auditReport.setSeq(rs.getString(3));
				auditReport.setAuditname(rs.getString(4));
				auditReport.setPlaceauditdate(rs.getString(5));
				auditReport.setAuditdate(rs.getString(6));
				
				auditReport.setAuditors(rs.getString(7));
				auditReport.setAuditfield(rs.getString(8));
				auditReport.setContractauditdate(rs.getString(9));
				auditReport.setMainclient(rs.getString(10));
				auditReport.setDevelopcompany(rs.getString(11));
				auditReport.setAuditcost(rs.getString(12));
				auditReport.setDevelopcost(rs.getString(13));
				auditReport.setDevelopmethod(rs.getString(14));
				auditReport.setBizoverview(rs.getString(15));
				auditReport.setBizscope(rs.getString(16));
				auditReport.setBizperiod(rs.getString(17));
				auditReport.setMaintechnology(rs.getString(18));
				auditReport.setAuditavailable(rs.getInt(19));
				auditReport.setAuditstartdate(rs.getString(20));
				auditReport.setAuditenddate(rs.getString(21));
				auditReport.setMainauditor(rs.getString(22));
				auditReport.setAuditstep(rs.getString(23));
				auditReport.setCreatedate(rs.getString(24));
				auditReport.setUpdatedate(rs.getString(25));
				
				return auditReport;
				
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
	
	public int update(int auditReportID,  AuditReport auditReport) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE auditReport" + 
				"SET" + 
				"    projectID = ?, " + 
				"    seq = ?, " + 
				"    auditName = ?, " + 
				"    placeAuditDate = ?, " + 
				"    auditDate = ?, " + 
				"    auditors = ?, " + 
				"    auditField = ?, " + 
				"    contractAuditDate = ?, " + 
				"    mainClient = ?, " + 
				"    developCompany = ?, " + 
				"    auditCost = ?, " + 
				"    developCost = ?, " + 
				"    developMethod = ?, " + 
				"    bizOverview = ?, " + 
				"    bizScope = ?, " + 
				"    bizPeriod = ?, " + 
				"    mainTechnology = ?, " + 
				"    auditAvailable = ?, " + 
				"    auditStartDate = ?, " + 
				"    auditEndDate = ?, " + 
				"    mainAuditor = ?, " + 
				"    auditStep = ?, " + 
				"    createDate = ?, " + 
				"    updateDate = ? " + 
				"WHERE auditReportID = ?";
				
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, auditReport.getProjectid());
			pstmt.setString(2, auditReport.getSeq());
			pstmt.setString(3, auditReport.getAuditname());
			pstmt.setString(4, auditReport.getPlaceauditdate());
			pstmt.setString(5, auditReport.getAuditdate());
			pstmt.setString(6, auditReport.getAuditors());
			pstmt.setString(7, auditReport.getAuditfield());
			pstmt.setString(8, auditReport.getContractauditdate());
			pstmt.setString(9, auditReport.getMainclient());
			pstmt.setString(10, auditReport.getDevelopcompany());
			pstmt.setString(11, auditReport.getAuditcost());
			pstmt.setString(12, auditReport.getDevelopcost());
			pstmt.setString(13, auditReport.getDevelopmethod());
			pstmt.setString(14, auditReport.getBizoverview());
			pstmt.setString(15, auditReport.getBizscope());
			pstmt.setString(16, auditReport.getBizperiod());
			pstmt.setString(17, auditReport.getMaintechnology());
			pstmt.setInt(18, auditReport.getAuditavailable());
			pstmt.setString(19, auditReport.getAuditstartdate());
			pstmt.setString(20, auditReport.getAuditenddate());
			pstmt.setString(21, auditReport.getMainauditor());
			pstmt.setString(22, auditReport.getAuditstep());
			pstmt.setString(23, auditReport.getCreatedate());
			pstmt.setString(24, auditReport.getUpdatedate());
			
			pstmt.setInt(25, auditReportID);
			
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
	
	
	public int delete(int auditReportID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from auditReport WHERE auditReportID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, auditReportID);
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
