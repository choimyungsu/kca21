<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.AuditReportDAO" %>
<%@ page import="com.pms.AuditReport" %>
<%@ page import="com.util.Util" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
<title>수행 감리 현황</title>
<jsp:include page="header.jsp" flush="true" />
<script type="text/javascript">

/* 
 * 
 // json 처리 스크립트 
 
 var request = new XMLHttpRequest();
function searchFunction(){
	request.open("Post","./AuditReportSearchServlet?auditName=" + encodeURIComponent(document.getElementById("auditName").value),true);
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
window.onload = function(){
	searchFunction();
} */
</script>
</head>
<body>

<% 

	int pageNumber = 1;
	if(request.getParameter("pageNumber") !=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	

	if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert(' 로그인을 하세요.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
    String search = "";// 검색어
    if(request.getParameter("search")!=null && request.getParameter("search")!=""){
        search = request.getParameter("search");
        //System.out.println("search========="+ search);
        
    }	
	
	if(request.getParameter("search")==null || request.getParameter("search")==""){
	    
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert(' 검색어를 입력하세요.')");
	    script.println("location.href = history.back()");
	    script.println("</script>");
	}	

%>


<div class="container-fluid">




			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">
						<span class="glyphicon glyphicon-search"></span>
						&nbsp;"<%=search %>"&nbsp;검색 결과
					</h3>	
				</div>
				<div class="panel-body">
                <!-- <div class="form-group row pull-right">
						<div class="col-xs-8">
							<input class="form-control" type="text" size="30" id="auditName" onkeyup="searchFunction();">
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary" onclick="searchFunction();" type="button"> 검색 </button>
						</div>
					</div> -->
					<div class="table-responsive">
					<table class="display" style="text-align: center; border: 1px solid #dddddd"  id="tableData1">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;">순번</th>
									<th style="background-color: #eeeeee; text-align: center;">감리명</th>
									<!-- <th style="background-color: #eeeeee; text-align: center;">현장감리일수</th> -->
									<!-- <th style="background-color: #eeeeee; text-align: center;">참여감리인</th> -->
									<th style="background-color: #eeeeee; text-align: center;">담당분야</th>
									<!-- <th style="background-color: #eeeeee; text-align: center;">감리계약기간</th> -->
									<th style="background-color: #eeeeee; text-align: center;">발주처(주관)</th>
									<!-- <th style="background-color: #eeeeee; text-align: center;">피감리기관</th> -->
									<!-- <th style="background-color: #eeeeee; text-align: center;">감리비(원)</th> -->
									<!-- <th style="background-color: #eeeeee; text-align: center;">사업비(백만원)</th> -->
									<!-- <th style="background-color: #eeeeee; text-align: center;">개발방법론</th> -->
									<th style="background-color: #eeeeee; text-align: center;">사업개요(목표)</th>
									<th style="background-color: #eeeeee; text-align: center;">사업범위(대상업무)</th>
									<!-- <th style="background-color: #eeeeee; text-align: center;">사업기간</th> -->
									<th style="background-color: #eeeeee; text-align: center;">요소기술</th>
								</tr>
							</thead>
							<tbody id="ajaxTable">
					<%
						AuditReportDAO auditReportDAO = new AuditReportDAO();
						ArrayList<AuditReport> list = auditReportDAO.likeSearchAuditorReport(search);
						
						Util util = new Util();
						for(int i =0 ; i < list.size(); i++){
							//int j = i +1 ;
					%>
								<tr>
									<td><%= list.get(i).getSeq() %></td>
									<td><a href ="auditReportView.jsp?auditReportID=<%= list.get(i).getAuditreportid() %>"> <%= list.get(i).getAuditname() %></a></td>
									<%-- <td title="<%=list.get(i).getPlaceauditdate() %>"><%= util.cutStirng(list.get(i).getPlaceauditdate(),20) %></td> --%>
									<%-- <td title="<%=list.get(i).getAuditors() %>"><%= list.get(i).getAuditors() %></td> --%>
									<td title="<%=list.get(i).getAuditfield() %>"><%= list.get(i).getAuditfield() %></td>					
									<%-- <td title="<%=list.get(i).getContractauditdate() %>"><%= util.cutStirng(list.get(i).getContractauditdate(),20) %></td> --%>
									<td title="<%=list.get(i).getMainclient() %>"><%= list.get(i).getMainclient() %></td>
									<%-- <td title="<%=list.get(i).getDevelopcompany() %>"><%= util.cutStirng(list.get(i).getDevelopcompany(),20) %></td> --%>
									<%-- <td title="<%=list.get(i).getAuditcost() %>"><%= util.cutStirng(list.get(i).getAuditcost(),20) %></td>
									<td title="<%=list.get(i).getDevelopcost() %>"><%= util.cutStirng(list.get(i).getDevelopcost(),20) %></td>
									<td title="<%=list.get(i).getDevelopmethod() %>"><%= util.cutStirng(list.get(i).getDevelopmethod(),20) %></td> --%>
									<td title="<%=list.get(i).getBizoverview() %>"><%= list.get(i).getBizoverview() %></td>
									<td title="<%=list.get(i).getBizscope() %>"><%= list.get(i).getBizscope() %></td>
									<%-- <td title="<%=list.get(i).getBizperiod() %>"><%= util.cutStirng(list.get(i).getBizperiod(),20) %></td> --%>
									<td title="<%=list.get(i).getMaintechnology() %>"><%= list.get(i).getMaintechnology() %></td>

									
								</tr>
						<%
						
						}
							
						%> 
							</tbody>
							</table>
							<button id='DLtoExcel-1'  class="btn btn-danger">Excel 저장</button>
							</div>
	
					
				</div>
			</div>
	
	</div>
        <script>
            
            $(document).ready(function() {
                $('#tableData1').DataTable();
            } );
            
            //엑셀 다운로드 
            var $btnDLtoExcel1 = $('#DLtoExcel-1');
               $btnDLtoExcel1.on('click', function () {
                   $("#tableData1").excelexportjs({
                       containerid: "tableData1"
                       , datatype: 'table'
                   });

               });

        </script>

</body>
</html>