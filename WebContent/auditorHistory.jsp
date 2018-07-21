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
<%@ page import="com.pms.AuditGroupCount" %>
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
	String auditNo = user.getAuditno();//감리원증 번호
	String updateDate = user.getUpdatedate(); // 최종업데이트 날짜 
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
	                                    <%= userDept %><br> <%= userLevel %> <br> 감리원증번호:<%=auditNo %> <br><br> 최종업데이트 날짜 <br><%=updateDate %></div>
	                                    <div class="col-sm-10">
	                                        <!--Table-->
									        <!-- <table class="table table-bordered"> -->
									        <table id="tableData0" class="table table-striped table-bordered" cellspacing="0" width="100%">
									            <!--Table head-->
									            <thead>
									                <tr>
									                    <th>#</th>
									                    <th>감리유형</th>
									                    <th>건수</th>
									                </tr>
									            </thead>
									            <!--Table head-->
									            <!--Table body-->
									            <tbody>
									            <%
									                    ArrayList<AuditGroupCount> list5 = auditHistoryDAO.getAuditFieldGroupList(searchUserID);
									                    for(int i =0 ; i < list5.size(); i++){
									            %>          
									                            <tr>
									                                <th scope="row"><%= i+1 %></th>
									                                <td><%= list5.get(i).getAuditField() %></td>
									                                <td><%= list5.get(i).getCount() %></td>
									                            </tr>
									            <% } %>             
									            </tbody>
						                        <!--Table body-->
						                        <tfoot>
					                                <tr>
					                                    <th colspan="3" style="text-align:right">  전체: </th>
					                                </tr>
					                            </tfoot>
						                    </table>
						                    <!--Table-->
	                                    </div>
	                                    
	                                </div>
	                            </div>
	                        </div>
	                        <div class="row">
			                      <div class="col-sm-2">
			                      </div>
	                              <div class="col-sm-10">
	                               <div id="columnchart_values" ></div>
			                     </div>
	                        </div>                  
	                    </div>
	                </div>
	                
  <script>
        
        
        $(document).ready(function() {  // 
            $('#tableData0').DataTable( {
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
                        //'$'+pageTotal +' ( $'+ total +' total)'
                            pageTotal +' ( '+ total +' total)'
                    );
                }
            } );
        } );
        

            
        </script>	                
              <!-- 감리인 인적사항  끝-->
              <!-- 감리이력 시작-->
              <div class="tab-pane <% if(tab.equals("history")){ %>  active <% } %> " id="2a">
                <br>
                        <!-- <table  class="display" style="text-align: center; border: 1px solid #dddddd ;width:100%" id="tableData1" > -->
                        <table id="tableData1" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
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
                        //AuditHistoryDAO auditHistoryDAO2 = new AuditHistoryDAO();
                        ArrayList<AuditHistory> list = auditHistoryDAO.getList(searchUserID);
                        for(int i =0 ; i < list.size(); i++){
                            //int j = i +1 ;
                    %>
                                <tr>
                                    <td align="center"><%= i+1 %></td>
                                    <td><%= list.get(i).getAudityearmonth() %></td>
                                    <td><a href="updateAuditorHistory.jsp?auditHistoryID=<%= list.get(i).getAudithistoryid() %>"><%= list.get(i).getAuditname() %></a></td>  
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
    
                    <a href="writeAuditorHistory.jsp" class="btn btn-primary pull-right">추가</a>
                    <button id='DLtoExcel-1'  class="btn btn-danger">Excel 저장</button>


        <script>
        // 데이터테이블 준비..
        // tab 과 데이터 테이블 연계를 위해서는 아래 4줄 필요.
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
            <!-- 감리이력 끝-->
         
            <!-- 사업유관경력 시작-->
            <div class="tab-pane <% if(tab.equals("career")){ %> active <% } %>" id="3a">
                <br>
                        <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tableData2">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
                                    <th style="background-color: #eeeeee; text-align: center;">사업개요</th>
                                    <th style="background-color: #eeeeee; text-align: center;">참여기간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">담당업무</th>
                                    <th style="background-color: #eeeeee; text-align: center;">유사경력근거</th>
                                    <th style="background-color: #eeeeee; text-align: center;">사업관리</th>
                                    <th style="background-color: #eeeeee; text-align: center;">응용</th>
                                    <th style="background-color: #eeeeee; text-align: center;">DB</th>
                                    <th style="background-color: #eeeeee; text-align: center;">아키텍처</th>
                                </tr>
                            </thead>
                            <tbody>
                    <%
                        CareerDAO careerDAO = new CareerDAO();
                        ArrayList<Career> list2 = careerDAO.getList(searchUserID);
                        for(int i =0 ; i < list2.size(); i++){
                    %>                          
                                <tr>
                                    <td align="center"><%= i+1 %></td>
                                    <td><%= util.changeStirng(list2.get(i).getCareerdesc()) %></td>
                                    <td><%= util.changeStirng(list2.get(i).getPeriod()) %></td>
                                    <td align="left"><a href="updateCareer.jsp?careerID=<%= list2.get(i).getCareerid() %>"><%= list2.get(i).getTask() %></a></td>
                                    <td><%= util.changeStirng(list2.get(i).getSimilarcareer()) %></td>
                                    <td><%= util.cutStirng(list2.get(i).getBiz(),20) %></td>
                                    <td><%= util.cutStirng(list2.get(i).getApp(),20) %></td>
                                    <td><%= util.cutStirng(list2.get(i).getDb(),20) %></td>
                                    <td><%= util.cutStirng(list2.get(i).getArchi(),20) %></td>
                                </tr>
                    <%
                        }
                    %>          

                            </tbody>
                          </table>
                    <a href="writeCareer.jsp" class="btn btn-primary pull-right">추가</a>
                    <button id='DLtoExcel-2'  class="btn btn-danger">Excel 저장</button>
                    

        <script>
        
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
                $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
            } );
         
         
        $('#tableData2').DataTable({
            "paging":   false,
            deferRender:    true,
            scrollY:        600,
            scrollCollapse: true,
            scroller:       true
        } );
    } ); 
        
         var $btnDLtoExcel2 = $('#DLtoExcel-2');
            $btnDLtoExcel2.on('click', function () {
                $("#tableData2").excelexportjs({
                    containerid: "tableData2"
                    , datatype: 'table'
                });

            });

        </script>
     </div>
            <!-- 사업유관경력 끝-->    
             
             <!-- 자격현황 시작-->   
             <div class="tab-pane <% if(tab.equals("certi")){ %> active <% } %>" id="4a">
                <br>
                        <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tableData3">
                            <thead>
                                <tr>
                                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
                                    <th style="background-color: #eeeeee; text-align: center;">자격증명</th>
                                    <th style="background-color: #eeeeee; text-align: center;">발급처</th>
                                    <th style="background-color: #eeeeee; text-align: center;">구분</th>
                                    <th style="background-color: #eeeeee; text-align: center;">관련분야</th>
                                </tr>
                            </thead>
                            <tbody>
                    <%
                        CertiDAO certiDAO = new CertiDAO();
                        ArrayList<Certi> list3 = certiDAO.getList(searchUserID);
                        for(int i =0 ; i < list3.size(); i++){
                            //int j = i +1 ;
                    %>                              
                                <tr>
                                    <td align="center"><%= i+1 %></td>                                                     
                                    <td><a href="updateCerti.jsp?certiID=<%= list3.get(i).getCertiid() %>"><%= list3.get(i).getCertiname() %></a></td>
                                    <td align="center"><%= list3.get(i).getIssuer() %></td>
                                    <td align="center"><%= list3.get(i).getCertidivision() %></td>
                                    <td align="center"><%= list3.get(i).getCertifield() %></td>
                                </tr>
                    <%
                        }
                    %>      
                                                
                            </tbody>
                          </table>
                    <a href="writeCerti.jsp" class="btn btn-primary pull-right">추가</a>
                    <button id='DLtoExcel-3'  class="btn btn-danger">Excel 저장</button>
                    
         <script>
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
                $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
            } );
         
         
        $('#tableData3').DataTable({
            "paging":   false,
            deferRender:    true,
            scrollY:        600,
            scrollCollapse: true,
            scroller:       true
        } );
    } ); 
        
         var $btnDLtoExcel3 = $('#DLtoExcel-3');
            $btnDLtoExcel3.on('click', function () {
                $("#tableData3").excelexportjs({
                    containerid: "tableData3"
                    , datatype: 'table'
                });

            });
            
        </script>
        </div>
        <!-- 자격현황 끝-->
               
        <!-- 교육현황 시작-->
         <div class="tab-pane <% if(tab.equals("edu")){ %> active <% } %>" id="5a">
                <br>
                        <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tableData4">
                            <thead>
                                <tr>
                                   <th style="background-color: #eeeeee; text-align: center;">번호</th>
                                    <th style="background-color: #eeeeee; text-align: center;">계속교육명</th>
                                    <th style="background-color: #eeeeee; text-align: center;">시간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">교육기간</th>
                                    <th style="background-color: #eeeeee; text-align: center;">교육기관</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                   <%
                        EduDAO eduDAO = new EduDAO();
                        ArrayList<Edu> list4 = eduDAO.getList(searchUserID);
                        for(int i =0 ; i < list4.size(); i++){
                            //int j = i +1 ;
                    %>                              
                                <tr>
                                    <td align="center"><%= i+1 %></td>                                                     
                                    <td><a href="updateEdu.jsp?eduID=<%= list4.get(i).getEduid() %>"><%= list4.get(i).getEdudesc() %></a></td>
                                    <td align="center"><%= list4.get(i).getEdutime() %></td>
                                    <td><%= list4.get(i).getEduperiod() %></td>
                                    <td align="center"><%= list4.get(i).getEduagency() %></td>
                                </tr>

                    <%
                        
                        }
                            
                    %> 
                            </tbody>
                            <tfoot>
					            <tr>
					                <th colspan="3" style="text-align:right">  교육시간: </th>
					                <th></th>
					                <th></th>
					            </tr>
					        </tfoot>
                          </table>
                    <a href="writeEdu.jsp" class="btn btn-primary pull-right">추가</a>
                    <button id='DLtoExcel-4'  class="btn btn-danger">Excel 저장</button>
                    
        
        <script>
        
       /*
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
                $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
            } );
         
         
        $('#tableData4').DataTable({
            "paging":   false,
            deferRender:    true,
            scrollY:        600,
            scrollCollapse: true,
            scroller:       true
        } );
    } ); 
        */
        
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
                        //'$'+pageTotal +' ( $'+ total +' total)'
                    		pageTotal +' ( '+ total +' total)'
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