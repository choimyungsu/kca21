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


</head>
<body>

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbortron" style="padding-top:20px;">
				<form method="post" action="writeCertiAction.jsp">
					<h3 style="text-align; center;">자격정보 작성</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="자격증명" name="certiname" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="발급처" name="issuer" maxlength="100">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="구분" name="certidivision" maxlength="200">
					</div>
					<div class="form-group">
                        <input type="text" class="form-control" placeholder="관련분야" name="certifield" maxlength="100">
                    </div>
                    
                    <div class="form-group">
                        <label for="expireDate" style="padding-right: 15px;">취득일 </label>
                        <div class="input-daterange date" id="datepicker1" style="width: 320px; display: inline-table;">
                          <input type="text" class="form-control" id="sdate1" style="width: 115px;" name="issuedate"/>
                          <label class="date-range" for="sdate1">
                            <i class="glyphicon glyphicon-calendar"></i>
                          </label>
                          
                        </div>
                    </div> 
                    
					
					<input type="submit" class="btn btn-primary form-control" value="자격등록">
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
        
        var sdate1 = new Date();
        sdate1.setDate(sdate1.getDate() - 7);
        $("#sdate1").datepicker('setDate', sdate1);
       // $("#edate1").datepicker('setDate', new Date());
        $('#datepicker1').datepicker('updateDates');
    })
</script>
</body>
</html>