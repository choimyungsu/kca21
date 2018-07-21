<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rfp.RfpDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");

/* String audityearmonth="";
if(request.getParameter("audityearmonth")!=null && request.getParameter("audityearmonth")!="0"){
    audityearmonth = request.getParameter("audityearmonth");
    System.out.println("들어 왔냐    audityearmonth="+audityearmonth);
}
 */


%>

<jsp:useBean id="rfp" class="com.rfp.Rfp" scope="page" />
<jsp:setProperty name="rfp" property="rfpid" />
<jsp:setProperty name="rfp" property="rfpname" />
<jsp:setProperty name="rfp" property="type" />
<jsp:setProperty name="rfp" property="duedate" />


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
            //System.out.println("auditHistory.getAudityearmonth()====>"+ auditHistory.getAudityearmonth() );
            
            if(rfp.getRfpname() == null || rfp.getDuedate() == null || rfp.getType() == null ) {
                
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                
                RfpDAO rfpDAO = new RfpDAO();
                int result = rfpDAO.update(rfp.getRfpid(),rfp.getRfpname(),rfp.getDuedate(),rfp.getType());
                
                if(result == -1){
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('제안 변경에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");                    
                }else{
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href ='viewRfp.jsp?rfpid="+rfp.getRfpid()+"'");
                    script.println("</script>");
                }
            }
        }


    %>
    
</body>
</html>