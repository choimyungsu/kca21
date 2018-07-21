package com.calendar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CalendarDAO {
	
	DataSource ds;
	public CalendarDAO() {//생성자 에서 선언
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/kca21");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//
		public ArrayList<Calendar> searchCalendarList(String defaultDate, String toDate){
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			String SQL = " select calendarID, " +
						 "  ifnull(id,''), " +
						 "  ifnull(title,''), " +
						 "  start, " +
						 "  end, " +
						 "  ifnull(url,'') " +
						 " from calendar " +
						 " WHERE  start between  ? and  ?  ";
			
	
			 ArrayList<Calendar> list = new ArrayList();
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, defaultDate); // 매월 1일
				pstmt.setString(2, toDate); // 그다음월 1일 
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Calendar calendar = new Calendar();	
					
					calendar.setCalendarid(rs.getInt(1));
					calendar.setId(rs.getString(2));
					calendar.setTitle(rs.getString(3));
					if(rs.getDate(4) !=null) {
						calendar.setStart(rs.getDate(4).toString()); // Date 타입을 스트링으로 변환 
					}
					if(rs.getDate(5) !=null) {
						calendar.setEnd(rs.getDate(5).toString()); // Date 타입을 스트링으로 변환 
					}
					calendar.setUrl(rs.getString(6));
			        
			        list.add(calendar);
					
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
		
		// JSON 타입 변환 
		public String getCalendarListJSON(String defaultDate) {
			StringBuffer result = new StringBuffer("");
			ArrayList<Calendar> clendar = this.searchCalendarList("2018-01-01", "2022-01-01");
			result.append(" events: [" );// 처음 시작
			for(int i=0; i<clendar.size(); i++) {
				
				result.append("{ ");
				if(clendar.get(i).getId()!=null && clendar.get(i).getId().length()>0) {
					result.append("id: \"" +clendar.get(i).getId() + "\",");
				}
				result.append("calendarID: \"" +clendar.get(i).getCalendarid() + "\",");
				result.append("title: \"" +clendar.get(i).getTitle() + "\",");
				result.append("start: \"" +clendar.get(i).getStart() + "\",");
				result.append("end: \"" +clendar.get(i).getEnd() + "\",");
				result.append("url: \"" +clendar.get(i).getUrl() + "\" ");
				
				result.append("} ");
				//마지막 줄 처리 
				if(clendar.size() > (i+1)) { result.append(",");}
				
			}
			
			result.append( "]");
			//System.out.println("result.toString()"+result.toString());
			return result.toString();

			
			}
		
		
		//일정 추가 
		public int insert(String title, Date start, Date end) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "INSERT INTO calendar (title,start,end)  VALUES (? ,?, ? )";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, title);
				pstmt.setDate(2, start);
				pstmt.setDate(3, end);
				
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
		
		
		//일정 변경 
		public int update(String title, Date start, Date end, Integer calendarID) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "UPDATE  calendar set title =? ,start =? ,end=? where calendarID =? ";
			
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, title);
				pstmt.setDate(2, start);
				pstmt.setDate(3, end);
				pstmt.setInt(4, calendarID);
				
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
		
		//일정 삭제 
		public int delete( Integer id) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "delete  from calendar  where calendarID =? ";
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, id);
				
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
