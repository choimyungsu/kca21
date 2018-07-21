<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.user.UserDAO" %>
<%@ page import="com.file.Linkfile" %>  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src="js/bootstrap.js"></script>
<script src="js/excelexportjs.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  
<% 
    String userID = null;
    String userImg = "default.png";
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
        
        //user 테이블에서 해당 사용자 이미지 가져오기
        UserDAO userDAO = new UserDAO();
        Linkfile fileDTO = userDAO.getFileInformation("user",userID);//
        if(fileDTO != null){
            if( fileDTO.getRealfilename() !=null ){
                   userImg = fileDTO.getRealfilename();
            }
        }
        
    }
	
	String searchType = "2";// 검색 종류, default는 감리인 
	if(request.getParameter("searchType")!=null && request.getParameter("searchType")!=""){
	    searchType = request.getParameter("searchType");
	    System.out.println("searchType========="+ searchType);
	    
	}	
	
%>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
				        data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				        aria-expanded="false">
				        <span class="sr-only"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">메인</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<!-- <li class="active"><a href="main.jsp">메인</a></li> -->
					<!-- <li><a href="auditReport.jsp">수행감리 현황</a></li> -->
					<li><a href="auditorHistory.jsp">감리인이력</a></li>
					<li><a href="userSearch.jsp">감리인찾기</a></li>
					<li><a href="auditReport.jsp">감리보고서대장</a></li>
					<% if(userID !=null && userID.equals("cms")){%>
                           <li><a href="rfplist.jsp">제안서 작성 현황</a></li> 
                           <li><a href="calendar.jsp">제안서 제출 일정</a></li>
                    <% } %>
					<!-- <li><a href="#">공지사항</a></li> -->
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
						    aria-haspopup="true" aria-expanded="false"> 제안서 작성 도움  <span class="caret"></span></a>
						    <ul class="dropdown-menu">
						          <li><a href="https://goo.gl/DX3nsL" target="_blank"> 감리전략 모음 </a></li>
						          <li><a href="https://goo.gl/ydKHa8" target="_blank"> 제안서 템플릿 사례 </a></li>
						          <!-- <li><a href="#"> 제안서 체크리스트 </a></li> -->
						         <!-- <li><a href="rfplist.jsp">제안서 작성 현황</a></li> 
						          <li><a href="calendar.jsp">제안서 제출 일정</a></li> -->
						    	<!-- <li><a href="#"> 프로젝트 등록 </a></li>
						    	<li><a href="#"> 감리인별 프로젝트 등록 </a></li>
						    	<li><a href="#"> 감리인별 교육실적 등록 </a></li>
						    	<li><a href="#"> 감리일정</a></li>
						    	<li><a href="#"> 관리자 메뉴 </a></li> -->
						    </ul>
					</li>
				</ul>
		        <form class="navbar-form navbar-left"   id="myform"  method="post">   <!-- action="searchAuditorlist.jsp" -->
		            <div class="form-group">
		                <input type=radio name="searchType" id="searchType" <% if(searchType.equals("1")){ %> checked <% } %> value="1"> 보고서대장
		                <input type=radio name="searchType" id="searchType" <% if(searchType.equals("2")){ %> checked <% } %> value="2"> 감리인이력
		                <input type=radio name="searchType" id="searchType" <% if(searchType.equals("3")){ %> checked <% } %> value="3"> 감리외경력
		                <input type="text" class="form-control" id="search" name="search" placeholder="내용을 입력하세요.">
		            </div>
		            <button type="button" onclick="submitForm()" class="btn btn-default" >검색</button>
		        </form>
				<%
					if(userID == null){
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
						data-toggle ="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li class="active"><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
				<%
					}else{
				%>
				<ul class="nav navbar-nav navbar-right">
			        <li>
			              <img class="img-circle" src="userImages/<%= userImg %>" width="40" height="45" alt="사진">
			        </li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
						data-toggle ="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속ID : <%= userID %><span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
							<li><a href="userChangeForm.jsp">정보변경</a></li>
    <%
        if(userID.equals("cms")){
    %>                
                            <li><a href="fileUpload.jsp">파일업로드</a></li>
                 
     <% 
         } 
     %>							
						</ul>
					</li>
				</ul>
				<%
					}
				%>
			</div>
		</div>
	</nav>
	
	<script type="text/javascript">
		function submitForm(){
			var searchType = $("#searchType:checked").val();
            var search =$("#search").val();
            //alert("searchType="+searchType +"==search="+search);
            if(searchType=="1"){
                $("#myform").attr('action', 'searchAuditorReport.jsp'); //searchAuditorReport
            }else if(searchType=="2"){
                $("#myform").attr('action', 'searchAuditorlist.jsp');
            }else{
            	$("#myform").attr('action', 'searchCareerlist.jsp');
            }
            $("#myform").submit();
		}
</script>
	
	
	
	
	 <script> 
    
        // Attach an event for when the user submits the form
      /*  
        $('form').on('submit', function(event) {
            
            // Prevent the page from reloading
            event.preventDefault();
            
            // 선택 유형 찾기
            var searchType = $("#searchType:checked").val();
            var search =$("#search").val();

            alert("searchType="+searchType +"==search="+search);
            if(searchType=="1"){
            	$("#myform").attr('action', 'searchAuditorlist.jsp'); //searchAuditorReport
            }else{
            	$("#myform").attr('action', 'searchAuditorlist.jsp');
            }
            
        });
       */
    </script>
	