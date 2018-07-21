<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.pms.CareerDAO" %>  
<%@ page import="com.pms.Career" %> 
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
                                    <th style="background-color: #eeeeee; text-align: center;">사업개요</th>
                                    <th style="background-color: #eeeeee; text-align: center;">참여기간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">담당업무</th>
                                    <th style="background-color: #eeeeee; text-align: center;">유사경력근거</th>
                                    <th style="background-color: #eeeeee; text-align: center;">사업관리</th>
                                    <th style="background-color: #eeeeee; text-align: center;">응용개발</th>
                                    <th style="background-color: #eeeeee; text-align: center;">데이터베이스</th>
                                    <th style="background-color: #eeeeee; text-align: center;">아키텍처</th>
                                </tr>
                            </thead>
                            <tbody>
<%
                        
                        CareerDAO careerDAO = new CareerDAO();
                        ArrayList<Career> list = careerDAO.likeSearchList(search);
                        for(int i =0 ; i < list.size(); i++){
    
                    %>
                                <tr>
                                    <td><%= i+1 %></td>
                                    <td><%= list.get(i).getUsername() %></td>
                                    <td><%= list.get(i).getCareerdesc() %></td>
                                    <td><%= list.get(i).getPeriod() %></td>
                                    <td><%= list.get(i).getTask() %></td>
                                    <td><%= list.get(i).getSimilarcareer() %></td>
                                    <td><%= list.get(i).getBiz() %></td>
                                    <td><%= list.get(i).getApp() %></td>
                                    <td><%= list.get(i).getDb() %></td>
                                    <td><%= list.get(i).getArchi() %></td>
                                    
                                    
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
        </div>
    </div>

</body>
</html>