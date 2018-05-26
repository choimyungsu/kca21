<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.CareerDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="career" class="com.pms.Career" scope="page" />
<jsp:setProperty name="career" property="userid" />
<jsp:setProperty name="career" property="careerid" />


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
        	System.out.println("career.getCareerid()====>"+ career.getCareerid() );
            
            if(career.getCareerid() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('객체 아이디를 찾을수 없습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	CareerDAO careerDAO = new CareerDAO();
                int result = careerDAO.delete(career.getCareerid());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('사업유관경력 삭제에 실패했습니다.')");
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