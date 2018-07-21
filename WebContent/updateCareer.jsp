<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.Career" %>
<%@ page import="com.pms.CareerDAO" %>
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
    
    int careerID = 0;
    if(request.getParameter("careerID") != null) {
    	careerID = Integer.parseInt(request.getParameter("careerID"));
    	
    	System.out.println("careerID========"+careerID);
    }
    if(request.getParameter("careerID") == null) {
    
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 유효하지 않은 이력입니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");

    }
    
    Career career = new CareerDAO().getCareer(careerID);
    
    
    System.out.println("userID========"+userID);
    System.out.println("career.getUserid()========"+career.getUserid());
    
    if(!userID.equals(career.getUserid())){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 권한이 없습니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");
    }
    
    
%>


    <div class="container">
        <div class="form-horizontal">
            <div style="padding-top:20px;">
                <form method="post" action="updateCareerAction.jsp">
                    <h3 style="text-align: center;">사업유관 경력 작성</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">사업개요</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="사업개요" name="careerdesc" maxlength="100" value="<%=career.getCareerdesc() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">참여기간</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="참여기간" name="period" maxlength="100" value="<%=career.getPeriod() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">담당업무</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="담당업무" name="task" maxlength="200" value="<%=career.getTask() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">유사경력근거</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="유사경력근거" name="similarcareer" maxlength="100" value="<%=career.getSimilarcareer() %>">
                        </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label col-sm-2" for="bizoverview">사업관리<br>(Risk,이슈,특징)</label>
                          
                          <div class="col-sm-10">
                          <textarea class="form-control" placeholder="글 내용" name="biz" maxlength="2000" style="height: 100px;" ><%=career.getBiz() %></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label col-sm-2" for="bizoverview">응용개발<br>(업무,개발언어)</label>
                          <div class="col-sm-10">
                          <textarea class="form-control" placeholder="글 내용" name="app" maxlength="2000" style="height: 100px;" ><%=career.getApp() %></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label col-sm-2" for="bizoverview">데이터베이스<br>(빅데이터,이관,DW)</label>
                          <div class="col-sm-10">
                          <textarea class="form-control" placeholder="글 내용" name="db" maxlength="2000" style="height: 100px;" ><%=career.getDb() %></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label col-sm-2" for="bizoverview">아키텍처<br>(인프라,HW,NW,통신)</label>
                          <div class="col-sm-10">
                          <textarea class="form-control" placeholder="글 내용" name="archi" maxlength="2000" style="height: 100px;" ><%=career.getArchi() %></textarea>
                          </div>
                    </div>                     
                    
                    <input type="hidden" name="userid" value="<%= userID %>">
                    <input type="hidden" name="careerid" value="<%= careerID %>">
                    
                    <div class="row" >
	                    <div class="col-sm-2">
	                    </div>
	                    <div class="col-sm-2">
	                    <input type="submit" class="btn btn-primary btn-sm" value="수정">
	                    </div>
	                    <div class="col-sm-8">
	                    <a href="deleteCareerAction.jsp?careerid=<%=careerID %>" class="btn btn-danger btn-sm pull-right">삭제 </a>
	                    </div>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
    
    
    
    
    
    
    

</html>