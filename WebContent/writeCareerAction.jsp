<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.CareerDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="career" class="com.pms.Career" scope="page" />
<jsp:setProperty name="career" property="userid" />
<jsp:setProperty name="career" property="careerdesc" />
<jsp:setProperty name="career" property="period" />
<jsp:setProperty name="career" property="task" />
<jsp:setProperty name="career" property="similarcareer" />
<jsp:setProperty name="career" property="biz" />
<jsp:setProperty name="career" property="app" />
<jsp:setProperty name="career" property="db" />
<jsp:setProperty name="career" property="archi" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>등록</title>
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
        	System.out.println("career.getCareerdesc()====>"+ career.getCareerdesc() );
            
            if(career.getCareerdesc() == null || career.getPeriod() == null || career.getTask() == null || career.getSimilarcareer() == null	) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	CareerDAO careerDAO = new CareerDAO();
                int result = careerDAO.insertExcel(userID,career.getPeriod(),career.getCareerdesc(),career.getTask(),career.getSimilarcareer(),career.getBiz(),career.getApp(),career.getDb(),career.getArchi());
                
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('사업유관 경력 작성에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");                    
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href ='auditorHistory.jsp?tab=career' ");
                    script.println("</script>");
                }
            }
        }


	%>
	
</body>
</html>