<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.AuditReportDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="auditReport" class="com.pms.AuditReport" scope="page" />
<jsp:setProperty name="auditReport" property="seq" />
<jsp:setProperty name="auditReport" property="auditname" />
<jsp:setProperty name="auditReport" property="placeauditdate" />
<jsp:setProperty name="auditReport" property="auditdate" />
<jsp:setProperty name="auditReport" property="auditors" />
<jsp:setProperty name="auditReport" property="auditfield" />
<jsp:setProperty name="auditReport" property="contractauditdate" />
<jsp:setProperty name="auditReport" property="mainclient" />
<jsp:setProperty name="auditReport" property="developcompany" />
<jsp:setProperty name="auditReport" property="auditcost" />
<jsp:setProperty name="auditReport" property="developcost" />
<jsp:setProperty name="auditReport" property="developmethod" />
<jsp:setProperty name="auditReport" property="bizoverview" />
<jsp:setProperty name="auditReport" property="bizscope" />
<jsp:setProperty name="auditReport" property="bizperiod" />
<jsp:setProperty name="auditReport" property="maintechnology" />



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
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
            
            if(auditReport.getAuditname() == null || auditReport.getAuditors() == null || auditReport.getAuditfield() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	AuditReportDAO auditReportDAO = new AuditReportDAO();
                int result = auditReportDAO.insert(auditReport);
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('이력등록에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");                    
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href ='auditorReport.jsp' ");
                    script.println("</script>");
                }
            }
        }


	%>
	
</body>
</html>