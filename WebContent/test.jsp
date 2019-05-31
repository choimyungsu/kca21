<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.AuditHistoryDAO" %>
<%@ page import="com.pms.AuditHistory" %>
<%@ page import="com.pms.CareerDAO" %>
<%@ page import="com.pms.Career" %>
<%@ page import="com.pms.CertiDAO" %>
<%@ page import="com.pms.Certi" %>
<%@ page import="com.pms.EduDAO" %>
<%@ page import="com.pms.Edu" %>
<%@ page import="com.file.Linkfile" %>
<%@ page import="com.user.UserDAO" %>
<%@ page import="com.user.User" %>
<%@ page import="com.util.Util" %>
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

<title>감리인 감리 이력 확인</title>

<jsp:include page="header.jsp" flush="true" />

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
	
	UserDAO userDAO = new UserDAO();
	User user = new User();
	user = userDAO.userDetail(searchUserID);
	String userName =user.getUsername();// user명 가져오기
	String userDept =user.getUserdept(); // 부서
	String userLevel = user.getUserlevel();// 직급
	//user 테이블에서 해당 사용자 이미지 가져오기
	Linkfile fileDTO = userDAO.getFileInformation("user",searchUserID);//
	
	String userImg = "default.gif"; //default img
	if(fileDTO == null){
		userImg = "default.gif";
	}else{
		userImg = fileDTO.getRealfilename();
	}
	
	Util util = new Util();
	
	String tab="";
    if(request.getParameter("tab") !=null){
	   tab = request.getParameter("tab");
    }
	

%>

    <script type="text/javascript">
      
      
      google.charts.load("current", {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart2);
      function drawChart2() {
        var data = google.visualization.arrayToDataTable([
        	/*
          ["Element", "Density", { role: "style" } ],
          ["Copper", 8.94, "#b87333"],
          ["Silver", 10.49, "silver"],
          ["Gold", 19.30, "gold"],
          ["Platinum", 21.45, "color: #e5e4e2"] 
          */
<%
 		AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
          
		String auditFieldGroupJSON ="";
		auditFieldGroupJSON = auditHistoryDAO.getAuditFieldGroupJSON(searchUserID);

%>          
["Element", "Density", { role: "style" } ],
<%= auditFieldGroupJSON%> 

        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
          title: "분야별 감리 횟수",
          width: 1500,
          height: 600,
          bar: {groupWidth: "90%"},
          legend: { position: "none" },
        };
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
        chart.draw(view, options);
    }
      
    </script>
</head>
<body>



<div id="exTab1" class="container-fluid"> 

        <ul  class="nav nav-tabs">
            <li <% if(tab.equals("")){ %> class="active" <% } %> >
                <a  href="#1a" data-toggle="tab">인적사항</a>
            </li>
            <li <% if(tab.equals("history")){ %>  class="active" <% } %>  >
                <a href="#2a" data-toggle="tab">감리이력</a>
            </li>
            <li <% if(tab.equals("career")){ %>  class="active" <% } %>>
                <a href="#3a" data-toggle="tab">사업유관경력</a>
            </li>
	        <li <% if(tab.equals("certi")){ %>  class="active" <% } %>>
	           <a href="#4a" data-toggle="tab">자격현황</a>
            </li>
            <li <% if(tab.equals("edu")){ %>  class="active" <% } %>>
               <a href="#5a" data-toggle="tab">교육이수현황 </a>
            </li>
        </ul>

            <div class="tab-content">
            <!-- 감리인 인적사항  시작-->
              <div class="tab-pane <% if(tab.equals("")){ %> active <% } %> " id="1a">
                    <div id="demo1" >
				        <div class="row" style="padding: 30px;">
				           <br>
	                            <div class="media">
	                                <div class="media-left">
	                                    <a href="#"><img class="media-object" src="userImages/<%= userImg %>" width="120" height="144" alt="감리인 사진"></a>
	                                </div>
	                                <div class="media-body">
	                                    <div class="col-sm-2"><h4 class="media-heading"><%= userName %></h4><br>
	                                    <%= userDept %><br> <%= userLevel %></div>
	                                    <div class="col-sm-10">
	                                        <div id="columnchart_values" ></div>
	                                    </div>
	                                    
	                                </div>
	                            </div>
	                        </div>                  
	                    </div>
	                </div>
              <!-- 감리인 인적사항  끝-->
              <!-- 감리이력 시작-->
              <!-- <div class="tab-pane <% if(tab.equals("history")){ %>  active <% } %> " id="2a">
                <br>
                        <table id="tableData1" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;"><input type="checkbox"></th>
                                    <th style="background-color: #eeeeee; text-align: center;">상태</th>
                                    <th style="background-color: #eeeeee; text-align: center;">상태동작시간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">성명</th>
                                    <th style="background-color: #eeeeee; text-align: center;">소속</th>
                                    <th style="background-color: #eeeeee; text-align: center;">부서</th>
                                    <th style="background-color: #eeeeee; text-align: center;">탈출명령 작동시간</th>
                                </tr>
                            </thead>
                            <tbody>
   
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center"><font color="red"><b>비상(SOS)</b></font></td>
                                    <td align="center">2018.6.1. 10:44:00</td>  
                                    <td align="center">가길동</td>
                                    <td align="center">동남서방서</td>
                                    <td align="center">소방행정과</td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center"><font color="blue"><b>동작</b></font></td>
                                    <td align="center">2018.6.1. 10:44:00</td>  
                                    <td align="center">나길동</td>
                                    <td align="center">서북서방서</td>
                                    <td align="center">소방행정과</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center"><font color="green"><b>대기</b></font></td>
                                    <td align="center">2018.6.1. 10:44:00</td>  
                                    <td align="center">디길동</td>
                                    <td align="center">아산서방서</td>
                                    <td align="center">쌍용센터</td>
                                    <td align="center">2018.6.1 10:44:01</td>
                                </tr> 
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>  
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>  
                                                             
                
                            </tbody>
                            </table>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">추가</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">수정</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">삭제</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">인쇄</a>
                             
                    <a href="writeAuditorHistory.jsp" class="btn btn-danger pull-right">탈출명령</a> &nbsp;
                     &nbsp;<a href="writeAuditorHistory.jsp" class="btn btn-success pull-right">집결명령</a> -->
                   
                    
                    <!-- 감리이력 시작-->
              <div class="tab-pane <% if(tab.equals("history")){ %>  active <% } %> " id="2a">
                <br>
                        <!-- <table  class="display" style="text-align: center; border: 1px solid #dddddd ;width:100%" id="tableData1" > -->
                        <table id="tableData1" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;"><input type="checkbox"></th>
                                    <th style="background-color: #eeeeee; text-align: center;">소속</th>
                                    <th style="background-color: #eeeeee; text-align: center;">부서</th>
                                    <th style="background-color: #eeeeee; text-align: center;">차종</th>
                                    <th style="background-color: #eeeeee; text-align: center;">계급</th>
                                    <th style="background-color: #eeeeee; text-align: center;">성먕</th>
                                    <th style="background-color: #eeeeee; text-align: center;">도착시간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">집결명령 작동시간</th>
                                </tr>
                            </thead>
                            <tbody>
   
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center">동남서방서</td>
                                    <td align="center">소방행정과</td>  
                                    <td align="center">통제단운영차</td>
                                    <td align="center">소방위</td>
                                    <td align="center">가길동</td>
                                    <td align="center">2018.6.1. 10:44:00</td>
                                    <td align="center"></td>
                                </tr>
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center">서북서방서</td>
                                    <td align="center">쌍용센터</td>  
                                    <td align="center">소형펌프차</td>
                                    <td align="center">소방위</td>
                                    <td align="center">나길동</td>
                                    <td align="center">2018.6.1. 10:44:00</td>
                                    <td align="center">2018.6.1. 10:30:00</td>
                                </tr>
                               <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center">아산서방서</td>
                                    <td align="center">인주센터</td>  
                                    <td align="center">대형펌프차</td>
                                    <td align="center">소방교</td>
                                    <td align="center">다길동</td>
                                    <td align="center">2018.6.1. 10:44:00</td>
                                    <td align="center">2018.6.1. 10:30:00</td>
                                </tr>
                                <tr>
                                    <td align="center"><input type="checkbox"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>  
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                </tr>                                
                                                             
                
                            </tbody>
                            </table>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">추가</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">수정</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">삭제</a>
                             <a href="writeAuditorHistory.jsp" class="btn btn-primary ">인쇄</a>
                             
                    <a href="writeAuditorHistory.jsp" class="btn btn-danger pull-right">탈출명령</a> &nbsp;
                     &nbsp;<a href="writeAuditorHistory.jsp" class="btn btn-success pull-right">집결명령</a>


        <script>
        // 데이터테이블 준비..
        // tab 과 데이터 테이블 연계를 위해서는 아래 4줄 필요.비
         $(document).ready(function() {
        	    $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
        	        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
        	    } );
        	 
        	 
            $('#tableData1').DataTable({
                "paging":   false,
                deferRender:    true,
                scrollY:        600,
                scrollCollapse: true,
                scroller:       true
            } );
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
         
                    
        
        <script>
        

        
        $(document).ready(function() {  // 
            $('#tableData4').DataTable( {
            	"paging":   false,
            	
                "footerCallback": function ( row, data, start, end, display ) {
                    var api = this.api(), data;
         
                    // Remove the formatting to get integer data for summation
                    var intVal = function ( i ) {
                        return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '')*1 :
                            typeof i === 'number' ?
                                i : 0;
                    };
         
                    // Total over all pages
                    total = api
                        .column( 2 )  // 3번째 컬럼 지정 
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Total over this page
                    pageTotal = api
                        .column( 2, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
         
                    // Update footer
                    $( api.column( 2 ).footer() ).html(
                        '$'+pageTotal +' ( $'+ total +' total)'
                    );
                }
            } );
        } );
        
        
         var $btnDLtoExcel4 = $('#DLtoExcel-4');
            $btnDLtoExcel4.on('click', function () {
                $("#tableData4").excelexportjs({
                    containerid: "tableData4"
                    , datatype: 'table'
                });

            });
            
        </script>
        
         </div>
         <!-- 교육현황 끝 -->
      </div> <!-- tab-content 끝 -->
  </div> <!-- exTab1 끝 -->


</body>
</html>