<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.rfp.RfpDAO" %>  
<%@ page import="com.rfp.Rfp" %> 
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

<link rel="stylesheet" href="ttps://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<title> CMS </title>
</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<%

if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
    
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(' 로그인을 하세요.')");
    script.println("location.href = 'main.jsp'");
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
                                                         제안서
                    </h3>   
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table  class="display" style="text-align: center; border: 1px solid #dddddd" id="tableData1">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;">No</th>
                                    <th style="background-color: #eeeeee; text-align: center;">RFP 공고명</th>
                                    <th style="background-color: #eeeeee; text-align: center;">제안 제출일</th>
                                    <th style="background-color: #eeeeee; text-align: center;">유형</th>
                                </tr>
                            </thead>
                            <tbody>
<%
                        RfpDAO rfpDAO = new RfpDAO();
                        ArrayList<Rfp> list = rfpDAO.getList();
                        
                        
                        for(int i =0 ; i < list.size(); i++){
                            //int j = i +1 ;
                    %>
                                <tr>
                                    <td><%= i+1 %></td>
                                    <td><a href="viewRfp.jsp?rfpid=<%= list.get(i).getRfpid() %>"><%= list.get(i).getRfpname() %></a></td>
                                    <td><%= list.get(i).getDuedate() %></td>
                                    <td><%= list.get(i).getType() %></td>
                                </tr>
                        <%
                        
                        }
                            
                        %>
                         </tbody>
                        </table>
                        <a href="writeRfp.jsp" class="btn btn-primary pull-right">추가</a>
                        
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