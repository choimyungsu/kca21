<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.Edu" %>
<%@ page import="com.pms.EduDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>변경</title>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<% 
    String userID = null;
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    
    int eduID = 0;
    if(request.getParameter("eduID") != null) {
    	eduID = Integer.parseInt(request.getParameter("eduID"));
    	
    	System.out.println("eduID========"+eduID);
    }
    if(request.getParameter("eduID") == null) {
    
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 유효하지 않은 교육이력입니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");

    }
    
    Edu edu = new EduDAO().getEdu(eduID);
    
    
    System.out.println("userID========"+userID);
    System.out.println("edu.getUserid()========"+edu.getUserid());
    
    if(!userID.equals(edu.getUserid())){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 권한이 없습니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");
    }
    
    
%>


    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbortron" style="padding-top:20px;">
                <form method="post" action="updateEduAction.jsp">
                    <h3 style="text-align; center;">교육이수현황 수정</h3>
                    <div class="form-group">
                                                     계속교육명 <input type="text" class="form-control" placeholder="계속교육명" name="edudesc" maxlength="100" value="<%=edu.getEdudesc() %>">
                    </div>
                    <div class="form-group">
                                                       시간 <input type="text" class="form-control" placeholder="시간" name="edutime" maxlength="100" value="<%=edu.getEdutime() %>">
                    </div>
                    <div class="form-group">
                                                       교육기간 <input type="text" class="form-control" placeholder="교육기간" name="eduperiod" maxlength="200" value="<%=edu.getEduperiod() %>">
                    </div>
                    <div class="form-group">
                                                        교육기관 <input type="text" class="form-control" placeholder="교육기관" name="eduagency" maxlength="100" value="<%=edu.getEduagency() %>">
                    </div>
                    
                    <input type="hidden" name="userid" value="<%= userID %>">
                    <input type="hidden" name="eduid" value="<%= eduID %>">
                    
                    <input type="submit" class="btn btn-primary btn-sm" value="수정">
                    <a href="deleteEduAction.jsp?eduid=<%=eduID %>" class="btn btn-danger btn-sm pull-right">삭제 </a>
                    
                </form>
            </div>
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
    
    
    
    
    
    
    

</html>