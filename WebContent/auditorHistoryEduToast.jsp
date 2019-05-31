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
		                modifyData: './AuditHistoryEduServlet?userID=<%=searchUserID%>', // 서블릿으로 변경
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
            <li>
                <a href="auditorHistoryToast.jsp?searchUserID=<%= searchUserID%>&tab=history" >감리이력</a>
            </li>
            <li>
                <a href="auditorHistoryCareerToast.jsp?searchUserID=<%= searchUserID%>&tab=career">사업유관경력</a>
            </li>
            <li>
               <a href="auditorHistoryCertiToast.jsp?searchUserID=<%= searchUserID%>&tab=certi" >자격현황</a>
            </li>
            <li class="active">
                <a href="#5a" data-toggle="tab">교육이수현황</a>
            </li>
        </ul>

            <div class="tab-content">
               <br>
               <% 
                   String jsonString = new EduDAO().getListJSON(searchUserID);
               
               %>
               
               <div id="grid"></div>
               <div id="pagination" class="tui-pagination"></div>
               <input type="button"  onclick="fn_add()" class="btn btn-primary btn-sm" value="행추가">
               <!-- <input type="button"  onclick="fn_copy()" class="btn btn-primary btn-sm" value="행복사"> -->
               <input type="button"  onclick="fn_remove()" class="btn btn-primary btn-sm" value="행삭제">
               <input type="button"  onclick="fn_save()" class="btn btn-primary btn-sm" value="저장">
               <!-- <input type="button"  onclick="fn_delete2()" class="btn btn-primary btn-sm" value="삭제"> -->
           
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
            title: '계속교육명',
            name: 'eduDesc',
            editOptions: {
                type: 'text',
                useViewMode: true
            }
        },
        {
            title: '시간',
            name: 'eduTime',
            editOptions: {
                type: 'text',
                useViewMode: true
            }
        },
        {
            title: '교육기간',
            name: 'eduPeriod',
            editOptions: {
                type: 'text',
                useViewMode: true
            }
        },
        {
            title: '교육기관',
            name: 'eduAgency',
            editOptions: {
                type: 'text',
                useViewMode: true
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
  
  
  
  
</script>

</body>
</html>