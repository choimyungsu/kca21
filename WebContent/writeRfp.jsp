<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/bootstrap-datepicker3.min.css">


<title>감리</title>
<jsp:include page="header.jsp" flush="true" />

<% 
    String userID = null;

    if((String) session.getAttribute("userID") == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 로그인을 하세요.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }else{
    	userID = (String) session.getAttribute("userID"); // 찾는 사용자가 없을 경우 세션아이디로 찾음
    }

%>

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
<div class="bootstrap-iso">
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbortron" style="padding-top:20px;">
				<form method="post" action="writeRfpAction.jsp" >
					<h3 style="text-align; center;">제안서(RFP) 작성</h3>
					<div class="form-group">
					<label for="rfpname" style="padding-right: 15px;">제안요청서 제목 </label>
						<input type="text" class="form-control" placeholder="제안요청서 제목" name="rfpname" maxlength="100">
					</div>
					<div class="form-group">
					<label for="type" style="padding-right: 15px;">유형 </label>
						<input type="text" class="form-control" placeholder="유형" name="type" maxlength="100">
					</div>
					
			        <div class="form-group">
			            <label for="expireDate" style="padding-right: 15px;">제출일 </label>
			            <div class="input-daterange date" id="datepicker1" style="width: 120px; display: inline-table;">
			              <input type="text" class="form-control" id="duedate" style="width: 115px;" name="duedate"/>
			              <label class="date-range" for="duedate">
                            <i class="glyphicon glyphicon-calendar"></i>
                          </label>
			            </div>
			        </div> 


					
					<input type="hidden" name="userid" value="<%= userID %>">
					<br>
					<input type="submit" class="btn btn-primary form-control" value="등록">
				</form>
			</div>
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
        
        var duedate1 = new Date();
        duedate1.setDate(duedate1.getDate() - 7);
        $("#duedate").datepicker('duedate', duedate1);
        $('#datepicker1').datepicker('updateDates');
    })
</script>

</body>
</html>