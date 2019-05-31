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
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">



<title>감리인 감리 이력 확인</title>

<jsp:include page="header.jsp" flush="true" />


<!-- TOAST UI 적용  2019.01.03 CDN 적용 start 위치 중요!! jquery 밑으로.. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.3.3/backbone.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>

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
      
      
    function fn_add(){
        grid.appendRow();
    }

    function fn_remove(){
        grid.removeCheckedRows();
    }
    
    function fn_copy(){
        var rowData = grid.getCheckedRows();
        grid.appendRow(rowData,{at:rowData.rowKey+1});
    }
    
    function fn_save(){ 
	     if(grid.isModified()){
		      grid.checkAll();
		      grid.use('Net', {
		            //perPage: 3,
		           // modifyDataMethod: 'POST',
		            api: {
		                
		                createData: './AuditHistoryServlet?userID=<%=searchUserID%>',
		                updateData: './AuditHistoryServlet',
		                modifyData: './AuditHistoryServlet?userID=<%=searchUserID%>', // 서블릿으로 변경
		                deleteData: './AuditHistoryServlet'
		            }
		        });
		      
		        var net = grid.getAddOn('Net');
		        
		        net.request('modifyData');
		        /*
		        net.request('createData'); // Send a request to '/api/createData'
		        net.request('updateData'); // Send a request to '/api/updateData'
		        net.request('deleteData'); // Send a request to '/api/deleteData'
		        */
	     }else{
	    	 alert("변경된데이터가 업습니다.");
	     }

    }
      
    </script>
</head>
<body>



<div id="exTab1" class="container-fluid"> 

        <ul  class="nav nav-tabs">
            <li>
                <a  href="#1a" data-toggle="tab">인적사항</a>
            </li>
            <li   class="active"  >
                <a href="#2a" data-toggle="tab">감리이력</a>
            </li>
            <li <% if(tab.equals("career")){ %>  class="active" <% } %>>
                <a href="./auditorHistoryCareerToast.jsp?searchUserID=<%= searchUserID%>&tab=career" >사업유관경력</a>
            </li>
            <li <% if(tab.equals("certi")){ %>  class="active" <% } %>>
               <a href="auditorHistoryCertiToast.jsp?searchUserID=<%= searchUserID%>&tab=certi" >자격현황</a>
            </li>
            <li <% if(tab.equals("edu")){ %>  class="active" <% } %>>
               <a href="auditorHistoryEduToast.jsp?searchUserID=<%= searchUserID%>&tab=edu">교육이수현황 </a>
            </li>
        </ul>

            <div class="tab-content">
            
            <!-- 감리인 인적사항  시작-->
              <div class="tab-pane <% if(tab.equals("")){ %> active <% } %> " id="1a">
              </div>
              
              <div class="tab-pane <% if(tab.equals("history")){ %>  active <% } %> " id="2a">
	               <br>
	               <% 
	                   String jsonString = new AuditHistoryDAO().getListJSON(searchUserID);
	               %>
	               
	               <div id="grid"></div>
	               <div id="pagination" class="tui-pagination"></div>
	               <input type="button"  onclick="fn_add()" class="btn btn-primary btn-sm" value="행추가">
	               <!-- <input type="button"  onclick="fn_copy()" class="btn btn-primary btn-sm" value="행복사"> -->
	               <input type="button"  onclick="fn_remove()" class="btn btn-primary btn-sm" value="행삭제">
	               <input type="button"  onclick="fn_save()" class="btn btn-primary btn-sm" value="저장">
	               <!-- <input type="button"  onclick="fn_delete2()" class="btn btn-primary btn-sm" value="삭제"> -->
               </div>
               <div class="tab-pane <% if(tab.equals("career")){ %>  active <% } %> " id="3a">
                   <br>
                   
                   <div id="grid3" width="100%" ></div>
                   <input type="button"  onclick="fn_add()" class="btn btn-primary btn-sm" value="행추가">
                   <input type="button"  onclick="fn_remove()" class="btn btn-primary btn-sm" value="행삭제">
                   <input type="button"  onclick="fn_save()" class="btn btn-primary btn-sm" value="저장">
               </div>

               <div class="tab-pane <% if(tab.equals("certi")){ %>  active <% } %> " id="4a">
               
               </div>
               
               <div class="tab-pane <% if(tab.equals("edu")){ %>  active <% } %> " id="5a">
               
               </div>
         
           
      </div> <!-- tab-content 끝 -->
  </div> <!-- exTab1 끝 -->



<script type="text/javascript">

  var grid = new tui.Grid({
      el: $('#grid'),
      scrollX: false,
      scrollY: false,
      rowHeaders: ['checkbox'],//체크박스 추가
      pagination: false,
      perPage: 10,
      columns: [
          {
              title: '연도',
              name: 'auditYearMonth',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '사업명',
              name: 'auditName',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '주관기관',
              name: 'mainClient',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '공공/민간',
              name: 'mainDivision',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '담당분야',
              name: 'auditField',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '역할',
              name: 'auditRole',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '참여율',
              name: 'joinRate',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          
          {
              title: '시작일',
              name: 'auditStartDate',
              editOptions: {
                  type: 'text'
              },
              component: {
                  name: 'datePicker',
                  options: {
                      format: 'yyyy-MM-dd'
                  }
              }
          },
          {
              title: '종료일',
              name: 'auditEndDate',
              editOptions: {
                  type: 'text'
              },
              component: {
                  name: 'datePicker',
                  options: {
                      format: 'yyyy-MM-dd'
                  }
              }
          },
          
          
      ]
  });
  //gridData :json 형태 값  
  var json = <%= jsonString  %> ; //  gridData 값만 추출이 필요함.
  grid.setData(json.gridData); // 값만 추출하기
  
  
  grid.on('successResponse', function(data) { // 성공값을 받았을 경우..
	  // when the result is true
	  location.reload();
      
  });
  
  
/*
  
  var pagination = new tui.Pagination('pagination', {
      totalItems: Number(grid.getRowCount()), // 전체 행수
      itemsPerPage: 10,
      template: {
          page: '<a href="#" class="tui-page-btn">{{page}}</a>',
          currentPage: '<strong class="tui-page-btn tui-is-selected">{{page}}</strong>',
          moveButton:
              '<a href="#" class="tui-page-btn tui-{{type}} custom-class-{{type}}">' +
                  '<span class="tui-ico-{{type}}">{{type}}</span>' +
              '</a>',
          disabledMoveButton:
              '<span class="tui-page-btn tui-is-disabled tui-{{type}} custom-class-{{type}}">' +
                  '<span class="tui-ico-{{type}}">{{type}}</span>' +
              '</span>',
          moreButton:
              '<a href="#" class="tui-page-btn tui-{{type}}-is-ellip custom-class-{{type}}">' +
                  '<span class="tui-ico-ellip">...</span>' +
              '</a>'
      }
  });
  
  pagination.on('beforeMove', function(eventData) {
      //return confirm('Go to page ' + eventData.page + '?');
      $('.wrap-loading').removeClass('display-none');
  });

  pagination.on('afterMove', function(eventData) {
      //alert('The current page is ' + eventData.page);
      goPage(eventData.page);
  });

  */

// add career

  var grid3 = new tui.Grid({
      el: $('#grid3'),
      scrollX: false,
      scrollY: false,
      rowHeaders: ['checkbox'],//체크박스 추가
      pagination: false,
      perPage: 10,
      columns: [
    	  {
              title: '사업개요',
              name: 'careerDesc',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '참여기간',
              name: 'period',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '담당업무',
              name: 'task',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '유사경력근거',
              name: 'similarCareer',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '사업관리',
              name: 'biz',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '응용',
              name: 'app',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: 'DB',
              name: 'db',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          {
              title: '아키텍처',
              name: 'archi',
              editOptions: {
                  type: 'text',
                  useViewMode: true
              }
          },
          
      ]
  });

  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
</script>

</body>
</html>