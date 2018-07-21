<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.pms.AuditReportDAO" %>
<%@ page import="com.pms.AuditReport" %>
<%@ page import="java.util.ArrayList" %>

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
	
	
	int auditReportID = 0;
	if(request.getParameter("auditReportID") != null){
		auditReportID = Integer.parseInt(request.getParameter("auditReportID"));
	}
	if(auditReportID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert(' 유효하지 않은 글입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
		
	AuditReport auditReport = new AuditReportDAO().getAuditReport(auditReportID);

%>


<div class="container-fluid">

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					<span class="glyphicon glyphicon-pencil"></span>
					&nbsp;&nbsp; 수행감리 현황 상세
				</h3>	
			</div>
			<div class="panel-body">

					<form class="form-horizontal" action="AuditReportWrite.jsp">
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="seq">순번</label>
						    <div class="col-sm-3">
						      <input type="text" class="form-control" id="seq" placeholder="순번" value="<%=auditReport.getSeq() %>">
						    </div>
						    <label class="control-label col-sm-1" for="auditname">감리명</label>
						    <div class="col-sm-7"> 
						      <input type="text" class="form-control" id="auditname" placeholder="감리명" value="<%=auditReport.getAuditname() %>">
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="placeauditdate">현장감리일수</label>
						    <div class="col-sm-3"> 
						      <input type="text" class="form-control" id="placeauditdate" placeholder="현장감리일수" value="<%=auditReport.getPlaceauditdate() %>">
						    </div>
						     <label class="control-label col-sm-1" for="auditors">참여감리인:</label>
						    <div class="col-sm-7"> 
						      <input type="text" class="form-control" id="auditors" placeholder="참여감이인" value="<%=auditReport.getAuditors() %>">
						    </div>
						  </div>

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="auditfield">담당분야</label>
						    <div class="col-sm-11"> 
						      <textarea class="form-control" placeholder="담당분야" name="auditfield" maxlength="2048" style="height: 100px;" > <%=auditReport.getAuditfield() %> </textarea>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="contractauditdate">감리계약기간</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="contractauditdate" placeholder="감리계약기간"  value="<%=auditReport.getContractauditdate() %>">
						    </div>
						    <label class="control-label col-sm-1" for="bizperiod">사업기간</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="bizperiod" placeholder="사업기간" value="<%=auditReport.getBizperiod() %>" >
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="mainclient">발주처(주관)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="mainclient" placeholder="발주처(주관)" value="<%=auditReport.getMainclient() %>" >
						    </div>
						    <label class="control-label col-sm-1" for="developcompany">피감리기관</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="developcompany" placeholder="피감리기관" value="<%=auditReport.getDevelopcompany() %>" >
						    </div>
						  </div>  						  					  
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="auditcost">감리비(원)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="auditcost" placeholder="감리비(원)" value="<%=auditReport.getAuditcost() %>" >
						    </div>
						    <label class="control-label col-sm-1" for="developcost">사업비(백만원)</label>
						    <div class="col-sm-5"> 
						      <input type="text" class="form-control" id="developcost" placeholder="사업비(백만원)" value="<%=auditReport.getDevelopcost() %>" >
						    </div>
						  </div>						  

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="developmethod">개발방법론</label>
						    <div class="col-sm-11"> 
						      <input type="text" class="form-control" id="developmethod" placeholder="개발방법론" value="<%=auditReport.getDevelopmethod() %>" >
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="bizoverview">사업개요<br>(목표)</label>
						    <div class="col-sm-11">
						    <textarea class="form-control" placeholder="글 내용" name="bizoverview" maxlength="2048" style="height: 100px;" > <%=auditReport.getBizoverview() %> </textarea>
						    </div>
						  </div>						  						  						  
						  <div class="form-group">
						    <label class="control-label col-sm-1" for="bizscope">사업범위<br>(대상업무)</label>
						    <div class="col-sm-11"> 
							<textarea class="form-control" placeholder="글 내용" name="bizscope" maxlength="2048" style="height: 100px;" > <%=auditReport.getBizscope() %> </textarea>
						    </div>
						  </div>

						  <div class="form-group">
						    <label class="control-label col-sm-1" for="maintechnology">요소기술</label>
						    <div class="col-sm-11"> 
						      <input type="text" class="form-control" id="maintechnology" placeholder="요소기술" value="<%=auditReport.getMaintechnology() %>">
						    </div>
						  </div>						  					  

						  <div class="form-group"> 
						    <div class="col-sm-offset-1 col-sm-11">
						      
						      <a href="auditReport.jsp" class="btn btn-default">목록</a>
						      <a href="updateAuditReportAction.jsp?bbsID=<%= auditReportID %>" class="btn btn-default"> 수정 </a>
						      <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= auditReportID %>" class="btn btn-default"> 삭제 </a>
						    </div>
						  </div>
						  					
					</form>
				</div>
		</div>
</div>


</body>
</html>