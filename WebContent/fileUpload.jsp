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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<title> </title>
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
    
}else if(!userID.equals("cms")){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(' 관리자가 아닙니다.')");
    script.println("location.href = 'main.jsp'");
    script.println("</script>");
    
    
}else{


}

%>

  <div class="content-wrapper">
    <div class="container-fluid">
        <!-- 컨텐츠 검색  -->
        <div id="demo2" class="collapse show" role="tabpanel" aria-labelledby="headingOne"  >
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <span class="glyphicon glyphicon-pencil"></span>
                        &nbsp;&nbsp; 파일 업로드
                    </h3>   
                </div>
                <div class="panel-body">
					<div class="row" style="padding-left:20px;">
						<form method="post" action="fileUploadAction.jsp" enctype="multipart/form-data">
						       <div class="form-group">
                                    <input type=checkbox name="alldelete" id="alldelete" > 이전데이터 전체삭제
                                    
                                </div>
						       <div class="form-group">
			                        <input type=radio name="type" id="type" value="A"> 감리이력
			                        <input type=radio name="type" id="type" value="B"> 사업유관경력
			                        <input type=radio name="type" id="type" value="C"> 자격현황
			                        <input type=radio name="type" id="type" value="D"> 교육이수 현황
			                        <input type=radio name="type" id="type" value="E"> 사용자
			                    </div>
			
			                    <div class="form-group">
			                         DB에 등록할 파일을 첨부하고 업로드 버튼을 클릭하세요.
			                    </div>
							    <div class="form-group">
			                        <input type="file" name="file"><br>
			                    </div>
			
							<input type="submit" class="btn btn-primary" value="upload">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

	
</body>
</html>