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
				<form method="post" action="writeCareerAction.jsp">
					<h3 style="text-align; center;">사업유관 경력 작성</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="사업개요" name="careerdesc" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="참여기간" name="period" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="담당업무" name="task" maxlength="200">
					</div>
					<div class="form-group">
                        <input type="text" class="form-control" placeholder="유사경력근거" name="similarcareer" maxlength="100">
                    </div>
			        <div class="form-group">
                          <label class="control-label" for="bizoverview">사업관리(Risk,이슈,특징)</label>
                          <br>
                          <div>
                          <textarea class="form-control" placeholder="글 내용" name="biz" maxlength="2000" style="height: 100px;" ></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label" for="bizoverview">응용개발(업무,개발언어)</label>
                          <br>
                          <div>
                          <textarea class="form-control" placeholder="글 내용" name="app" maxlength="2000" style="height: 100px;" ></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label" for="bizoverview">데이터베이스(빅데이터,이관,DW)</label>
                          <br>
                          <div>
                          <textarea class="form-control" placeholder="글 내용" name="db" maxlength="2000" style="height: 100px;" ></textarea>
                          </div>
                    </div>
                    <div class="form-group">
                          <label class="control-label" for="bizoverview">아키텍처(아키,인프라,네트워크,통신)</label>
                          <br>
                          <div>
                          <textarea class="form-control" placeholder="글 내용" name="archi" maxlength="2000" style="height: 100px;" ></textarea>
                          </div>
                    </div>                 
					
					<input type="hidden" name="userid" value="<%= userID %>">
					
					<input type="submit" class="btn btn-primary form-control" value="경력등록">
				</form>
			</div>
		</div>
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>