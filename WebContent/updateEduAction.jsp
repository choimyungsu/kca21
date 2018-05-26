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
<jsp:setProperty name="edu" property="edudesc" />
<jsp:setProperty name="edu" property="edutime" />
<jsp:setProperty name="edu" property="eduperiod" />
<jsp:setProperty name="edu" property="eduagency" />

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
            
            if(edu.getEdudesc() == null || edu.getEdutime() == null || edu.getEduperiod() == null || edu.getEduagency() == null) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
                
            }else{
                
            	EduDAO eduDAO = new EduDAO();
                int result = eduDAO.update(edu.getEduid(),edu.getEdudesc(),edu.getEdutime(),edu.getEduperiod(),edu.getEduagency());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('수정에 실패했습니다.')");
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