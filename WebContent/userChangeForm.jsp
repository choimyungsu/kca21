<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.user.User" %>
<%@ page import="com.user.UserDAO" %>   
<%@ page import="com.file.Linkfile" %>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>감리</title>
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
    
  
    UserDAO userDAO = new UserDAO();
    
    User user = userDAO.userDetail(userID);
    //user 테이블에서 해당 사용자 이미지 가져오기
    Linkfile fileDTO = userDAO.getFileInformation("user",userID);//
    
    System.out.println("userID========"+userID);
    System.out.println("user.getUserid()========"+user.getUserid());
    
    if(!userID.equals(user.getUserid())){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 권한이 없습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }

%>

	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbortron" style="padding-top:20px;">
				<form method="post" action="updateUserAction.jsp" enctype="multipart/form-data">
					<h3 style="text-align; center;">회원 수정 화면</h3>
					<%-- <div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" value="<%=user.getUserid() %>">
					</div> --%>
					<div class="form-group">
						비밀번호 <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%=user.getUserpassword() %>">
					</div>
					<div class="form-group">
						이름 <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%=user.getUsername() %>">
					</div>
					<div class="form-group">
                                                         소속 <input type="text" class="form-control" placeholder="소속" name="org" maxlength="20" value="<%=user.getOrg() %>">
                    </div>
					<div class="form-group">
						부서 <input type="text" class="form-control" placeholder="부서" name="userDept" maxlength="20" value="<%=user.getUserdept() %>">
					</div>
					<div class="form-group">
						직급 <input type="text" class="form-control" placeholder="직급" name="userLevel" maxlength="20" value="<%=user.getUserlevel() %>">
					</div>
					<div class="form-group">
						이메일 <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" value="<%=user.getUseremail() %>">
					</div>
					<div class="form-group">
                                                        생년 <input type="text" class="form-control" placeholder="생년 ex)1960" name="userBirth" maxlength="20" value="<%=user.getBirth() %>">
                    </div>
					
					<div class="form-group">
						<input type="file" name="file"><br>
						<%= fileDTO.getFilename() %>
					</div>
					<input type="hidden" name="userID" value="<%= userID %>">
					<input type="submit" class="btn btn-primary form-control" value="회원정보 변경">
				</form>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>