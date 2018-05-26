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
            
            if(certi.getCertiid() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('객체 아이디를 찾을수 없습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	CertiDAO certiDAO = new CertiDAO();
                int result = certiDAO.delete(certi.getCertiid());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('자격정보 삭제에 실패했습니다.')");
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