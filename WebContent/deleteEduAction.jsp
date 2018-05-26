<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.EduDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="edu" class="com.pms.Edu" scope="page" />
<jsp:setProperty name="edu" property="userid" />
<jsp:setProperty name="edu" property="eduid" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정</title>
</head>
<body>
	<%
		
	//세션 확인
    String userID = null;
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
    }
        if(userID ==null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert(' 로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }else{
        	System.out.println("edu.getEduid()====>"+ edu.getEduid() );
            
            if(edu.getEduid() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('객체 아이디를 찾을수 없습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	EduDAO eduDAO = new EduDAO();
                int result = eduDAO.delete(edu.getEduid());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('교육이수정보 삭제에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");                    
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href ='auditorHistory.jsp' ");
                    script.println("</script>");
                }
            }
        }


	%>
	
</body>
</html>