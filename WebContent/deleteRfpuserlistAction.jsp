<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rfp.RfpuserlistDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="rfpuserlist" class="com.rfp.Rfpuserlist" scope="page" />
<jsp:setProperty name="rfpuserlist" property="rfpid" />
<jsp:setProperty name="rfpuserlist" property="rfpuserlistid" />

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
            
            if(rfpuserlist.getRfpuserlistid() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('객체 아이디를 찾을수 없습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
            	RfpuserlistDAO rfpuserlistDAO = new RfpuserlistDAO();
                int result = rfpuserlistDAO.delete(rfpuserlist.getRfpuserlistid());
                
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('삭제에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");                    
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href ='viewRfp.jsp?rfpid="+rfpuserlist.getRfpid()+"'");
                    script.println("</script>");
                }
            }
        }


	%>
	
</body>
</html>