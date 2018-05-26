<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.pms.AuditHistoryDAO" %>  
<%@ page import="com.pms.AuditHistory" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="ttps://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<title> CMS </title>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<%

String search = "";// 시험 종목
if(request.getParameter("search")!=null && request.getParameter("search")!=""){
    search = request.getParameter("search");
    //System.out.println("search========="+ search);
    
}

if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
    
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(' 로그인을 하세요.')");
    script.println("location.href = 'main.jsp'");
    script.println("</script>");
}

if(request.getParameter("search")==null || request.getParameter("search")==""){
    
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(' 검색어를 입력하세요.')");
    script.println("location.href = history.back()");
    script.println("</script>");
}

%>
  <div class="content-wrapper">
    <div class="container-fluid">
    <div id="demo2" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <span class="glyphicon glyphicon-pencil"></span>
                        &nbsp;"<%=search %>"&nbsp;검색 결과
                    </h3>   
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table  class="display" style="text-align: center; border: 1px solid #dddddd" id="tableData1">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
                                    <th style="background-color: #eeeeee; text-align: center;">감리인</th>
                                    <th style="background-color: #eeeeee; text-align: center;">연도</th>
                                    <th style="background-color: #eeeeee; text-align: center;">사업명</th>
                                    <th style="background-color: #eeeeee; text-align: center;">주관기관</th>
                                    <th style="background-color: #eeeeee; text-align: center;">공공/민간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">담당분야</th>
                                    <th style="background-color: #eeeeee; text-align: center;">역할</th>
                                    <th style="background-color: #eeeeee; text-align: center;">참여율</th>
                                </tr>
                            </thead>
                            <tbody>
<%
                        AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
                        ArrayList<AuditHistory> list = auditHistoryDAO.likeSearchAuditorHistoryList(search);
                        
                        for(int i =0 ; i < list.size(); i++){
                            //int j = i +1 ;
                    %>
                                <tr>
                                    <td><%= i+1 %></td>
                                    <td><%= list.get(i).getUsername() %></td>
                                    <td><%= list.get(i).getAudityearmonth() %></td>
                                    <td><%= list.get(i).getAuditname() %></td>
                                    <td><%= list.get(i).getMainclient() %></td>
                                    <td><%= list.get(i).getMaindivision() %></td>
                                    <td><%= list.get(i).getAuditfield() %></td>
                                    <td><%= list.get(i).getAuditrole() %></td>
                                    <td><%= list.get(i).getJoinrate() %></td>
                                </tr>
                        <%
                        
                        }
                            
                        %>
                         </tbody>
                        </table>
                       </div>
                    </div>
                </div>
            </div>
        <script>
            
            $(document).ready(function() {
                $('#tableData1').DataTable();
            } );

        </script>
        </div>
    </div>

</body>
</html>