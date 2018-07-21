package com.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.file.Linkfile;

import com.user.User;

public class UserDAO {

	
	DataSource ds;
	public UserDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT userPassword FROM user WHERE userID = ? ";
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				 if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공
				 }else{
					return 0;//비밀번호 불일치
				 }
			}
			return -1;//아이디가 없음
		}catch (Exception e) {
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
		return -2;// 데이터 베이스 오류
	}
	
	public int join(User user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, user.getUserpassword());
			pstmt.setString(3, user.getUsername());
			pstmt.setString(4, user.getUseremail());
			pstmt.setString(5, user.getUserdept());
			pstmt.setString(6, user.getUserlevel());
			pstmt.setString(7, user.getBirth());
			pstmt.setString(8, user.getOrg());
			pstmt.setInt(9, 0);
			pstmt.setString(10, "N");
			pstmt.setString(11, user.getAuditno());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				//if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1 ; // 데이텁이스 오류
	}
	
	
	public int update(User user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "UPDATE user SET userPassword = ? , userName = ? , userEmail = ?, userDept = ?, userLevel = ?, birth = ?, org = ?, auditNo = ? "
				+ " WHERE userID = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserpassword());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getUseremail());
			pstmt.setString(4, user.getUserdept());
			pstmt.setString(5, user.getUserlevel());
			pstmt.setString(6, user.getBirth());
			pstmt.setString(7, user.getOrg());
			pstmt.setString(8, user.getAuditno());
			
			pstmt.setString(9, user.getUserid());
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				//if(rs!=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1 ; // 데이텁이스 오류
	}
	
	public User userDetail(String  userID){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM user WHERE userID = ?  ";
		User user = new User();
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				user.setUserid(rs.getString(1));
				user.setUserpassword(rs.getString(2));
				user.setUsername(rs.getString(3));
				user.setUseremail(rs.getString(4));
				user.setUserdept(rs.getString(5));
				user.setUserlevel(rs.getString(6));
				user.setBirth(rs.getString(7));
				user.setOrg(rs.getString(8));
				user.setAvailable(rs.getInt(9));
				user.setManager(rs.getString(10));
				user.setAuditno(rs.getString(11));
				user.setUpdatedate(rs.getString(12));
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
		return user;//
	}

public ArrayList<User> search(String  userName){
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT a.userID, a.userPassword, a.userName,a.userEmail,a.userDept,a.userLevel,a.birth,a.org,a.available,a.manager,a.auditNo,a.updateDate, "
				+ " (select count(auditHistoryID) from auditHistory c where c.userID = a.userID ) cnt , "
				+ " (select sum(eduTime) from edu d where d.userID = a.userID ) edu  "
				+ " FROM user a WHERE userName like ?  ";
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			conn = ds.getConnection();
			pstmt  = conn.prepareStatement(SQL);

			pstmt.setString(1, "%" + userName + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				
				user.setUserid(rs.getString(1));
				user.setUserpassword(rs.getString(2));
				user.setUsername(rs.getString(3));
				user.setUseremail(rs.getString(4));
				user.setUserdept(rs.getString(5));
				user.setUserlevel(rs.getString(6));
				user.setBirth(rs.getString(7));
				user.setOrg(rs.getString(8));
				user.setAvailable(rs.getInt(9));
				user.setManager(rs.getString(10));
				user.setAuditno(rs.getString(11));
				user.setUpdatedate(rs.getString(12));
				
				user.setCnt(rs.getString(13)); // 총 감리이력
				user.setEdu(rs.getString(14)); // 총 교육이수시간
				

				list.add(user);
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


	
	

	//한건 가져오기
		public Linkfile getFileInformation(String objectLink, String objectLinkPK) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = " SELECT * FROM linkFile WHERE objectLink = ?  and objectLinkPK = ? ";
			try {
				conn = ds.getConnection();
				pstmt  = conn.prepareStatement(SQL);
				pstmt.setString(1, objectLink);
				pstmt.setString(2, objectLinkPK);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Linkfile fileDTO = new Linkfile();
					
					fileDTO.setLinkfileid(rs.getInt(1));
					fileDTO.setObjectlink(rs.getString(2));
					fileDTO.setObjectlinkpk(rs.getString(3));
					fileDTO.setFilename(rs.getString(4));
					fileDTO.setRealfilename(rs.getString(5));
					fileDTO.setFilepath(rs.getString(6));
					fileDTO.setDownloadcnt(rs.getInt(7));
					
					return fileDTO;
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
		
	
		public int update(String userID) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			//현재 시간으로 업데이트 하기..
			String SQL = "UPDATE user SET updateDate = now()  "
					+ " WHERE userID = ?";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				
				return pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					//if(rs!=null) rs.close();
					if(pstmt !=null) pstmt.close();
					if(conn!=null) conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return -1 ; // 데이텁이스 오류
		}
		
		
		
	
	
}
