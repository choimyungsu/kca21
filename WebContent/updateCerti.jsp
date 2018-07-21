<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.Certi" %>
<%@ page import="com.pms.CertiDAO" %>
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
    
    int certiID = 0;
    if(request.getParameter("certiID") != null) {
    	certiID = Integer.parseInt(request.getParameter("certiID"));
    	
    	System.out.println("certiID========"+certiID);
    }
    if(request.getParameter("certiID") == null) {
    
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 유효하지 않은 자격정보입니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");

    }
    
    Certi certi = new CertiDAO().getCerti(certiID);
    
    
    System.out.println("userID========"+userID);
    System.out.println("certi.getUserid()========"+certi.getUserid());
    
    if(!userID.equals(certi.getUserid())){
        
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
                <form method="post" action="updateCertiAction.jsp">
                    <h3 style="text-align; center;">자격정보 수정</h3>
                    <div class="form-group">
                                                      자격증명<input type="text" class="form-control" placeholder="자격증명" name="certiname" maxlength="100" value="<%=certi.getCertiname() %>">
                    </div>
                    <div class="form-group">
                                                     발급처<input type="text" class="form-control" placeholder="발급처" name="issuer" maxlength="100" value="<%=certi.getIssuer() %>">
                    </div>
                    <div class="form-group">
                                                      구분<input type="text" class="form-control" placeholder="구분" name="certidivision" maxlength="200" value="<%=certi.getCertidivision() %>">
                    </div>
                    <div class="form-group">
                                                     관련분야<input type="text" class="form-control" placeholder="관련분야" name="certifield" maxlength="100" value="<%=certi.getCertifield() %>">
                    </div>
                    
                    <input type="hidden" name="userid" value="<%= userID %>">
                    <input type="hidden" name="certiid" value="<%= certiID %>">
                    
                    <input type="submit" class="btn btn-primary btn-sm" value="수정">
                    <a href="deleteCertiAction.jsp?certiid=<%=certiID %>" class="btn btn-danger btn-sm pull-right">삭제 </a>
                    
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
    
    
    
    
    
    
    

</html>