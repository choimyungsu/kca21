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
<title>수행 감리 현황 상세</title>

</head>
<body>
<jsp:include page="header.jsp" flush="true" />


<% 
	String userID = null;
	if(session.getAttribute("userID") !=null ){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null){ // 세션아이디가 없으면 메인페이지로 돌려보냄.
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert(' 로그인을 하세요.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}

%>


<div class="container-fluid">

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					<span class="glyphicon glyphicon-pencil"></span>
					&nbsp;&nbsp; 감리보고서 대장
				</h3>	
			</div>
			<div class="panel-body">

					<form class="form-horizontal" action="writeAuditReportAction.jsp">
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="seq">순번</label>
						    <div class="col-sm-3">
						      <input type="text" class="form-control" id="seq" placeholder="순번" >
						    </div>
						    <label class="control-label col-sm-1" for="auditname">감리명</label>
						    <div class="col-sm-7"> 
						      <input type="text" class="form-control" id="auditname" placeholder="감리명" >
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="placeauditdate">현장감리일수</label>
						    <div class="col-sm-3"> 
						      <input type="text" class="form-control" id="placeauditdate" placeholder="현장감리일수" >
						    </div>
						     <label class="control-label col-sm-1" for="auditors">참여감리인:</label>
						    <div class="col-sm-7"> 
						      <input type="text" class="form-control" id="auditors" placeholder="참여감이인" >
						    </div>
						  </div>

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="auditfield">담당분야</label>
						    <div class="col-sm-11"> 
						      <textarea class="form-control" placeholder="담당분야" name="auditfield" maxlength="2048" style="height: 100px;" > </textarea>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="contractauditdate">감리계약기간</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="contractauditdate" placeholder="감리계약기간">
						    </div>
						    <label class="control-label col-sm-1" for="bizperiod">사업기간</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="bizperiod" placeholder="사업기간">
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="mainclient">발주처(주관)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="mainclient" placeholder="발주처(주관)">
						    </div>
						    <label class="control-label col-sm-1" for="developcompany">피감리기관</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="developcompany" placeholder="피감리기관">
						    </div>
						  </div>  						  					  
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="auditcost">감리비(원)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="auditcost" placeholder="감리비(원)" >
						    </div>
						    <label class="control-label col-sm-1" for="developcost">사업비(백만원)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="developcost" placeholder="사업비(백만원)"  >
						    </div>
						  </div>						  

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="developmethod">개발방법론</label>
						    <div class="col-sm-11"> 
						      <input type="text" class="form-control" id="developmethod" placeholder="개발방법론"  >
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="bizoverview">사업개요<br>(목표)</label>
						    <div class="col-sm-11">
						    <textarea class="form-control" placeholder="글 내용" name="bizoverview" maxlength="2048" style="height: 100px;" >  </textarea>
						    </div>
						  </div>						  						  						  
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="bizscope">사업범위<br>(대상업무)</label>
						    <div class="col-sm-11"> 
							<textarea class="form-control" placeholder="글 내용" name="bizscope" maxlength="2048" style="height: 100px;" >  </textarea>
						    </div>
						  </div>

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="maintechnology">요소기술</label>
						    <div class="col-sm-11"> 
						      <input type="text" class="form-control" id="maintechnology" placeholder="요소기술" >
						    </div>
						  </div>						  					  

						  <div class="form-group"> 
						    <div class="col-sm-offset-1 col-sm-11">
						      <button type="submit" class="btn btn-default">Submit</button>
						      <a href="auditReport.jsp" class="btn btn-default">목록</a>

						    </div>
						  </div>
						  					
					</form>
				</div>
		</div>
</div>


</body>
</html>