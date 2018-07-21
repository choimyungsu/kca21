<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.AuditHistory" %>
<%@ page import="com.pms.AuditHistoryDAO" %>
<%@ page import="com.user.User" %>
<%@ page import="com.user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/bootstrap-datepicker3.min.css">

<title>감리이력변경</title>


 <style type="text/css">
  
  .date-range {
    padding: 6px 12px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1;
    color: #555;
    text-align: center;
    background-color: #eee;
    border: 1px solid #ccc;
    border-radius: 4px;
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    cursor: pointer;
    width: auto;
    white-space: nowrap;
    vertical-align: middle;
    display: table-cell;
}
  </style>

</head>
<body>

<jsp:include page="header.jsp" flush="true" />

<% 
    String userID = null;
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 로그인을 하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    
    int auditHistoryID = 0;
    if(request.getParameter("auditHistoryID") != null) {
    	auditHistoryID = Integer.parseInt(request.getParameter("auditHistoryID"));
    	
    	System.out.println("auditHistoryID========"+auditHistoryID);
    }
    if(request.getParameter("auditHistoryID") == null) {
    
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 유효하지 않은 이력입니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");

    }
    
    AuditHistory aaa = new AuditHistoryDAO().getAuditHistory(auditHistoryID);
    User user = new UserDAO().userDetail(userID);
    
    System.out.println("userID========"+userID);
    System.out.println("aaa.getUserid()========"+aaa.getUserid());
    
    if(!userID.equals(aaa.getUserid()) && !user.getManager().equalsIgnoreCase("Y")){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 권한이 없습니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");
    }
    
    
%>


    <div class="container">
        <div class="form-horizontal" >
            <div style="padding-top:20px;">
                <form method="post" action="updateAuditorHistoryAction.jsp">
                    <h3 style="text-align:center;">감리인 이력 수정</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth" >연도</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="연도" name="audityearmonth" maxlength="100" value="<%=aaa.getAudityearmonth() %>" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">감리명</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="사업명" name="auditname" maxlength="100" value="<%=aaa.getAuditname() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">주관기관</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="주관기관" name="mainclient" maxlength="100" value="<%=aaa.getMainclient() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">공공/민간</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="공공/민간" name="maindivision" maxlength="100" value="<%=aaa.getMaindivision() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">담당분야</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="담당분야" name="auditfield" maxlength="100" value="<%=aaa.getAuditfield() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">역할</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="역할" name="auditrole" maxlength="100" value="<%=aaa.getAuditrole() %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="audityearmonth">참여율</label>
                        <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="참여율" name="joinrate" maxlength="100" value="<%=aaa.getJoinrate() %>">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="expireDate" style="padding-right: 15px;">감리기간 </label>
                        <div class="col-sm-10">
	                        <div class="input-daterange date" id="datepicker1" style="width: 320px; display: inline-table;">
	                          <input type="text" class="form-control" id="sdate1" style="width: 115px;" name="auditstartdate" value="<%=aaa.getAuditstartdate() %>"/>
	                          <label class="date-range" for="sdate1">
	                            <i class="glyphicon glyphicon-calendar"></i>
	                          </label>
	                          <span style="display: table-cell; padding: 0px 10px;"> ~ </span>
	                          <input type="text" class="form-control" id="edate1" style="width: 115px; border-radius: 3px 0 0 3px;" name="auditenddate" value="<%=aaa.getAuditenddate() %>"/>
	                          <label class="date-range" for="edate1">
	                            <i class="glyphicon glyphicon-calendar"></i>
	                          </label>
	                        </div>
                        </div>
                    </div> 
                    
                    
                    <input type="hidden" name="userid" value="<%= userID %>">
                    <input type="hidden" name="audithistoryid" value="<%= auditHistoryID %>">
                    
                    <div class="row" >
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-2">
                    <input type="submit" class="btn btn-primary btn-sm" value="수정">
                    </div>
                    <div class="col-sm-8">
                    <a href="deleteAuditorHistoryAction.jsp?audithistoryid=<%=auditHistoryID %>" class="btn btn-danger btn-sm pull-right">삭제 </a>
                    </div>
                    </div>
                    
                </form>
                
            </div>
        </div>
    </div>
    
<!-- Include jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Include Date Range Picker -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>    
<script>
!function(a) {
      a.fn.datepicker.dates.kr = {
        days : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
        daysShort : [ "일", "월", "화", "수", "목", "금", "토" ],
        daysMin : [ "일", "월", "화", "수", "목", "금", "토" ],
        months : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월",
            "11월", "12월" ],
        monthsShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월",
            "10월", "11월", "12월" ],
        titleFormat : "yyyy년 MM", /* Leverages same syntax as 'format' */
      }
    }(jQuery);

    $(document).ready(function() {      
        $('#datepicker1').datepicker({
          format : "yyyy-mm-dd",
          language : "kr",
          autoclose : true,
          todayHighlight : true
        }).on('hide', function(e) {
          e.stopPropagation(); // 모달 팝업도 같이 닫히는걸 막아준다.
        });
        
       /* var sdate1 = new Date();
        sdate1.setDate(sdate1.getDate() - 7);
        $("#sdate1").datepicker('setDate', sdate1);
        $("#edate1").datepicker('setDate', new Date());
        $('#datepicker1').datepicker('updateDates');
        */
    })
</script>
</body>
    
    
    
    
    
    
    

</html>