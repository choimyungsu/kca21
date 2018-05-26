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
<jsp:setProperty name="auditHistory" property="audityearmonth" />
<jsp:setProperty name="auditHistory" property="auditname" />
<jsp:setProperty name="auditHistory" property="mainclient" />
<jsp:setProperty name="auditHistory" property="maindivision" />
<jsp:setProperty name="auditHistory" property="auditfield" />
<jsp:setProperty name="auditHistory" property="auditrole" />
<jsp:setProperty name="auditHistory" property="joinrate" />
<jsp:setProperty name="auditHistory" property="auditstartdate" />
<jsp:setProperty name="auditHistory" property="auditenddate" />


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
            
            if(auditHistory.getAudityearmonth() == null || auditHistory.getAuditname() == null || auditHistory.getMainclient() == null || auditHistory.getMaindivision() == null
            		|| auditHistory.getAuditfield() == null || auditHistory.getAuditrole() == null || auditHistory.getJoinrate() == null) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
                int result = auditHistoryDAO.update(auditHistory.getAudithistoryid(),auditHistory.getAudityearmonth(),auditHistory.getAuditname(),auditHistory.getMainclient(),auditHistory.getMaindivision(),auditHistory.getAuditfield(),auditHistory.getAuditrole(),auditHistory.getJoinrate(),auditHistory.getAuditstartdate(),auditHistory.getAuditenddate());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('이력 수정에 실패했습니다.')");
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