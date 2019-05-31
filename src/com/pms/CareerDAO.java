package com.pms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.pms.Career;
import com.user.UserDAO;
import com.util.Util;

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
				career.setBiz(rs.getString(7));
				career.setApp(rs.getString(8));
				career.setDb(rs.getString(9));
				career.setArchi(rs.getString(10));
				
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




public String getListJSON(String userid){
	
	//ArrayList<Career> list = new ArrayList<Career>();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String jsonData="";
	String SQL = "SELECT * FROM career WHERE userid = ? ORDER BY period DESC ";
	
	try {
		conn = ds.getConnection();
		pstmt  = conn.prepareStatement(SQL);
		pstmt.setString(1, userid);
		
		rs = pstmt.executeQuery();
		Util util = new Util();
		jsonData = util.getJSONFromResultSet(rs,"gridData");// 공통함수 호출
		
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









//insert(엑셀)
	public int insertExcel(String userID, String period, String careerDesc, String task,String similarCareer,String biz, String app, String db, String archi) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "INSERT INTO career(userID, period ,careerDesc,task,similarCareer,biz,app,db,archi)  VALUES (?, ? ,?, ?, ?,?,?,?,? )";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, period);
			pstmt.setString(3, careerDesc);
			pstmt.setString(4, task);
			pstmt.setString(5, similarCareer);
			pstmt.setString(6, biz);
			pstmt.setString(7, app);
			pstmt.setString(8, db);
			pstmt.setString(9, archi);
			
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
		
		String SQL = "SELECT a.careerID,a.userID,a.period, a.careerDesc,a.task,a.similarCareer,a.biz,a.app,a.db,a.archi "
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
				career.setBiz(rs.getString(7));
				career.setApp(rs.getString(8));
				career.setDb(rs.getString(9));
				career.setArchi(rs.getString(10));
				
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
	
	public int update(int careerID, String careerdesc, String period, String task,String similarcareer,String biz, String app, String db, String archi, String userID ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE career SET careerDesc = ? , period = ? , task = ?, similarCareer = ?, biz = ?, app = ?, db = ?, archi = ? "
				+ " WHERE careerID = ?";
				
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, careerdesc);
			pstmt.setString(2, period);
			pstmt.setString(3, task);
			pstmt.setString(4, similarcareer);
			pstmt.setString(5, biz);
			pstmt.setString(6, app);
			pstmt.setString(7, db);
			pstmt.setString(8, archi);
			
			pstmt.setInt(9, careerID);
			
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
	
	public int deleteAll(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "Delete from career WHERE userID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, userID);
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
	
public ArrayList<Career> likeSearchList(String search){
		
		ArrayList<Career> list = new ArrayList<Career>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		
		// 쿼리문 바꾸기.
		String SQL = "SELECT b.userName,a.careerID,a.userID,a.period, a.careerDesc,a.task,a.similarCareer,a.biz,a.app,a.db,a.archi  "
				+"	FROM career a left outer join user b "
				+" on a.userid = b.userid"
				+" where careerDesc like ? "
				+"	or biz like  ? "
				+"	or app like  ? "
				+"	or db like  ? "
				+"	or archi like  ? " ;
		
		
		
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
				Career career = new Career();
				
				career.setUsername(rs.getString(1));
				career.setCareerid(rs.getInt(2));
				career.setUserid(rs.getString(3));
				career.setPeriod(rs.getString(4));
				career.setCareerdesc(rs.getString(5));
				career.setTask(rs.getString(6));
				career.setSimilarcareer(rs.getString(7));
				career.setBiz(rs.getString(8));
				career.setApp(rs.getString(9));
				career.setDb(rs.getString(10));
				career.setArchi(rs.getString(11));
				
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
	
	
	
	
	
}
