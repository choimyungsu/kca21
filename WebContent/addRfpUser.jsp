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



</head>
<body>
<% 

	int pageNumber = 1;
	if(request.getParameter("pageNumber") !=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
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
	}
	
	String searUserName = "";
	if(request.getParameter("searUserName") !=null){
		searUserName = request.getParameter("searUserName");
	}
	
     String rfpid = "";
	 if(request.getParameter("rfpid") !=null){
		 rfpid = request.getParameter("rfpid");
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

					</div>
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" id="ajaxTable">
							<thead>
								<tr>
								    <th style="background-color: #eeeeee; text-align: center;">선택</th>
									<th style="background-color: #eeeeee; text-align: center;">아이디</th>
									<th style="background-color: #eeeeee; text-align: center;">이름</th>
									<th style="background-color: #eeeeee; text-align: center;">소속</th>
									<th style="background-color: #eeeeee; text-align: center;">감리원증 번호</th>
									
									
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
								    <td><input type="checkbox" id="chkBox" value="<%= list.get(i).getUserid() %>"></td>
									<td><%= list.get(i).getUserid() %></td>
									<td><%= list.get(i).getUsername() %></td>
									<td><%= list.get(i).getOrg() %></td>
									<td><%= list.get(i).getAuditno() %></td>
								</tr>
						<%
						
						}
							
						%>
							</tbody>
						</table>

                        <input type="button"  onclick="saveUser()" class="btn btn-primary btn-sm pull-right" value="저장">
				</div>
			</div>
		</div>
		      <script>

            // 데이터테이블 준비..
            $(document).ready(function() {
                $('#ajaxTable').DataTable({
                    "paging":   false,
                    deferRender:    true,
                    scrollY:        500,
                    scrollCollapse: true,
                    scroller:       true
                } );
            } );

            
            function saveUser(){
            	   var ArrayCheck = new Array();    //배열선언
            	   // 체크된 항목 갑  배열에 넣기..
            	   $('#chkBox:checked').each(function() { 
            		   // alert($(this).val());
            		   ArrayCheck.push($(this).val());
            	   });
            	   location.href="addRfpUserAction.jsp?ArrayCheck="+ArrayCheck+"&rfpid=<%=rfpid%>";
            }
        </script>

</div>

</body>
</html>