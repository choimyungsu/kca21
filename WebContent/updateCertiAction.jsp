<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pms.CertiDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="certi" class="com.pms.Certi" scope="page" />
<jsp:setProperty name="certi" property="userid" />
<jsp:setProperty name="certi" property="certiid" />
<jsp:setProperty name="certi" property="certiname" />
<jsp:setProperty name="certi" property="issuer" />
<jsp:setProperty name="certi" property="certidivision" />
<jsp:setProperty name="certi" property="certifield" />
<jsp:setProperty name="certi" property="issuedate" />

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
        	System.out.println("certi.getCertiid()====>"+ certi.getCertiid() );
            
            if(certi.getCertiname() == null || certi.getIssuer() == null || certi.getCertidivision() == null || certi.getCertifield() == null) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");

                
            }else{
                
            	CertiDAO certiDAO = new CertiDAO();
                int result = certiDAO.update(certi.getCertiid(),certi.getCertiname(),certi.getIssuer(),certi.getCertidivision(),certi.getCertifield(),certi.getIssuedate());
                
                
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