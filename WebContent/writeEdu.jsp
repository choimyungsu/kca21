<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>감리</title>
<jsp:include page="header.jsp" flush="true" />

<% 
    String userID = null;

    if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 로그인을 하세요.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }else{
    	userID = (String) session.getAttribute("userID"); // 찾는 사용자가 없을 경우 세션아이디로 찾음
    }

%>


</head>
<body>

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbortron" style="padding-top:20px;">
				<form method="post" action="writeEduAction.jsp">
					<h3 style="text-align; center;">교육이수현황 작성</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="계속교육명" name="edudesc" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="시간" name="edutime" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="교육기간" name="eduperiod" maxlength="200">
					</div>
					<div class="form-group">
                        <input type="text" class="form-control" placeholder="교육기관" name="eduagency" maxlength="100">
                    </div>
					
					<input type="submit" class="btn btn-primary form-control" value="교육등록">
				</form>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>