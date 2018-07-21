<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.calendar.Calendar" %>
<%@ page import="com.calendar.CalendarDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일정 삭제 </title>
</head>
<body>
<%
	String userID = null;
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
        
    }else if(!userID.equals("cms")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 관리자가 아닙니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
        
        
    }else{

	    int calendarID = 0;
	    if(request.getParameter("calendarID") != null) {
	        calendarID = Integer.parseInt(request.getParameter("calendarID"));
	    }
	
	        CalendarDAO calendarDAO = new CalendarDAO();
	  	    int result=0 ;
	        
	    	 result = calendarDAO.delete( calendarID);
	    	 
	    	 //System.out.println("calendarID === "+calendarID);
	
	  	    
	          if(result == -1){
	              PrintWriter script = response.getWriter();
	              script.println("<script>");
	              script.println("alert('삭제에 실패했습니다.')");
	             // script.println("history.back()");
	              script.println("</script>");                    
	          }else{
	              PrintWriter script = response.getWriter();
	              script.println("<script>");
	              script.println("alert('삭제하였습니다.')");
	             // script.println("history.back()");
	              script.println("</script>");
	         }
    }
    	   
%>
    
</body>
</html>