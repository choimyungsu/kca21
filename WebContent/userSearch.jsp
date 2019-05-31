<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.user.UserDAO" %>
<%@ page import="com.user.User" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<link rel="stylesheet" href="ttps://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">

<jsp:include page="header.jsp" flush="true" />

<title>감리인 검색</title>

<script type="text/javascript">

// json 처리 스크립트 
 
 var request = new XMLHttpRequest();
function searchFunction(){
	request.open("Post","./UserSearchServlet?userName=" + encodeURIComponent(document.getElementById("userName").value),true);
	request.onreadystatechange = searchProcess;
	request.send(null);
}
function searchProcess(){
	var table = document.getElementById("ajaxTable");
	table.innerHTML ="";
	if(request.readyState == 4 && request.status == 200) {
		var object = eval('('+ request.responseText + ')');
		var result = object.result;
		for(var i= 0; i < result.length; i++){
			var row = table.insertRow(0);
			for(var j=0;j<result[i].length;j++){
				var cell = row.insertCell(j);
				cell.innerHTML = result[i][j].value;
			}
		}
		
	}
	
}
/* window.onload = function(){
	searchFunction();
}  */
</script>

</head>
<body>
<% 

	int pageNumber = 1;
	if(request.getParameter("pageNumber") !=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	String loginUser = "";

	
	String searchUserID = null;
	if(request.getParameter("searchUserID") !=null){
		searchUserID = request.getParameter("searchUserID");
	}else{
		searchUserID = (String) session.getAttribute("userID"); // 찾는 사용자가 없을 경우 세션아이디로 찾음
		
	}
	
	if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert(' 로그인을 하세요.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}else{
		loginUser = (String) session.getAttribute("userID");
	}
	
	String searUserName = "";
	if(request.getParameter("searUserName") !=null){
		searUserName = request.getParameter("searUserName");
	}

%>


<div class="container-fluid">
	<!-- 감리원 이력사항  -->
		<div id="demo2" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">
						<span class="glyphicon glyphicon-pencil"></span>
						&nbsp;&nbsp; 감리원 현황
					</h3>	
				</div>
				<div class="panel-body">
					<div class="form-group row pull-right">
<!-- 						<div class="col-xs-8">
							<input class="form-control" type="text" size="30" id="userName" onkeyup="searchFunction();">
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary" onclick="searchFunction();" type="button"> 검색 </button>
						</div> -->
					</div>
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" id="ajaxTable">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;">아이디</th>
									<th style="background-color: #eeeeee; text-align: center;">이름</th>
									<th style="background-color: #eeeeee; text-align: center;">이메일</th>
									<th style="background-color: #eeeeee; text-align: center;">소속</th>
									<th style="background-color: #eeeeee; text-align: center;">감리원증 번호</th>
									<th style="background-color: #eeeeee; text-align: center;">감리횟수</th>
									<th style="background-color: #eeeeee; text-align: center;">총교육시간</th>
									<th style="background-color: #eeeeee; text-align: center;">업데이트날짜</th>
									<th style="background-color: #eeeeee; text-align: center;">감리인이력보기</th>
									
								</tr>
							</thead>
							<tbody >
					<%
						UserDAO userDAO = new UserDAO();
						ArrayList<User> list = userDAO.search(searUserName);
						for(int i =0 ; i < list.size(); i++){
							//int j = i +1 ;
					%>
								<tr>
									<td><%= list.get(i).getUserid() %></td>
									<td><%= list.get(i).getUsername() %></td>
									<td><%= list.get(i).getUseremail() %></td>
									<td><%= list.get(i).getOrg() %></td>
									<td><%= list.get(i).getAuditno() %></td>
									<td><%= list.get(i).getCnt() %></td>
									<td><%= list.get(i).getEdu() %></td>
									<td><%= list.get(i).getUpdatedate() %></td>
									<td>
									   <a href="auditorHistory.jsp?searchUserID=<%= list.get(i).getUserid() %>">보기</a>
									   <% if(loginUser.equals("cms")){  %>
									      &nbsp; <a href="auditorHistoryToast.jsp?searchUserID=<%= list.get(i).getUserid()%>&tab=history">수정</a>
									   <%} %>
									</td>
								</tr>
						<%
						
						}
							
						%>
							</tbody>
						</table>


				</div>
			</div>
		</div>
		      <script>

            // 데이터테이블 준비..
            $(document).ready(function() {
                $('#ajaxTable').DataTable({
                    "paging":   false,
                    deferRender:    true,
                    scrollY:        600,
                    scrollCollapse: true,
                    scroller:       true
                } );
            } );

        </script>

</div>

</body>
</html>