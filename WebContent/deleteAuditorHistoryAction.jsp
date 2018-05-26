<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.AuditHistoryDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="auditHistory" class="com.pms.AuditHistory" scope="page" />
<jsp:setProperty name="auditHistory" property="userid" />
<jsp:setProperty name="auditHistory" property="audithistoryid" />


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
        	System.out.println("auditHistory.getAudithistoryid()====>"+ auditHistory.getAudithistoryid() );
            
            if(auditHistory.getAudithistoryid() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('객체 아이디를 찾을수 없습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
                int result = auditHistoryDAO.delete(auditHistory.getAudithistoryid());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('이력 삭제에 실패했습니다.')");
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