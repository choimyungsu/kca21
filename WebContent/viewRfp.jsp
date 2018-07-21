<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.rfp.Rfp" %>
<%@ page import="com.rfp.RfpDAO" %>
<%@ page import="com.rfp.Rfpuserlist" %>
<%@ page import="com.rfp.RfpuserlistDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">



<title>변경</title>
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
    
    int rfpid = 0;
    if(request.getParameter("rfpid") != null) {
    	rfpid = Integer.parseInt(request.getParameter("rfpid"));
    	
    	//System.out.println("rfpid========"+rfpid);
    }
    if(request.getParameter("rfpid") == null) {
    
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 유효하지 않은 정보입니다.')");
        script.println("location.href = 'rfplist.jsp'");
        script.println("</script>");

    }
    
    Rfp rfp = new RfpDAO().getRfp(rfpid);
   
    //
   // System.out.println("userID========"+userID);
    
    /*
    if(!userID.equals(career.getUserid())){
        
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(' 권한이 없습니다.')");
        script.println("location.href = 'auditorHistory.jsp'");
        script.println("</script>");
    }
    */
    
%>


    <div class="container-fluid">
        <div class="form-horizontal">
            <div style="padding-top:20px;">
	            <div class="panel panel-primary">
	                <div class="panel-heading">
	                    <h3 class="panel-title">
	                        <span class="glyphicon glyphicon-home"></span>
	                        &nbsp;&nbsp; 헤더 
	                    </h3>   
	                </div>
	                <div class="panel-body">
	                    <div class="row">
			                <form method="post" id="myform2" name="myform2" action="#">
			                        
			                       &nbsp; title : <b><%=rfp.getRfpname() %> </b> &nbsp; 제출일 :<%=rfp.getDuedate() %>&nbsp; 유형 :<%=rfp.getType() %>
			                    
			                    <input type="hidden" name="userid" value="<%= userID %>">
			                    <input type="hidden" name="rfpid" value="<%= rfpid %>">
			                   
			                    &nbsp; &nbsp;<button type="button" onclick="updateRfp();" class="btn-xs btn-success" >수정</button> &nbsp;
                                             <button type="button" onclick="deleteRfp();" class="btn-xs btn-danger" >삭제</button>
			                    
			             </div>
			        </div>
			     </div>

                 <div class="panel panel-primary">
		             <div class="panel-heading">
		                 <h3 class="panel-title">
		                     <span class="glyphicon glyphicon-list-alt"></span>
		                     &nbsp;&nbsp; 제안 작성 인력
		                 </h3>   
		             </div>
		             <div class="panel-body">            
	                    <!-- 제안 인력 리스트   -->
	                    <div class="row" style="padding:20px;" >
	                    
	                        <table id="tableData1" class="table table-striped table-bordered" cellspacing="0" width="100%">
	                            <thead>
	                                <tr>
	                                    <th style="background-color: #eeeeee; text-align: center;">선택</th>
	                                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
	                                    <th style="background-color: #eeeeee; text-align: center;">아이디 </th>
	                                    <th style="background-color: #eeeeee; text-align: center;">이름 </th>
	                                    <th style="background-color: #eeeeee; text-align: center;">감리원번호 </th>
	                                    <th style="background-color: #eeeeee; text-align: center;">총감리건수 </th>
	                                    <th style="background-color: #eeeeee; text-align: center;">담당영역</th>
	                                    <th style="background-color: #eeeeee; text-align: center;">총교육시간</th>
	                                    <th style="background-color: #eeeeee; text-align: center;">이력보기</th>
	                                    <th style="background-color: #eeeeee; text-align: center;">action</th>
	                                </tr>
	                            </thead>
	                            <tbody>
	                    <%
	                         ArrayList<Rfpuserlist> list = new RfpuserlistDAO().getList(rfpid);
	                        for(int i =0 ; i < list.size(); i++){
	                            //int j = i +1 ;
	                    %>
	                                <tr>
	                                    <td align="center"><input type="checkbox" id="chkBox" value="<%= list.get(i).getRfpuserlistid() %>"></td>
	                                    <td align="center"><%= i+1 %></td>
	                                    <td><%= list.get(i).getUserid() %></td>
	                                    <td><%= list.get(i).getUsername() %></td>
	                                    <td><%= list.get(i).getAuditno() %></td>
	                                    <td><%= list.get(i).getCnt() %></td>
	                                    <td><input type=text size=80 name="auditField" id="<%= list.get(i).getRfpuserlistid() %>" value="<%= list.get(i).getAuditfield() %>"></td>
	                                    <td><%= list.get(i).getEduTime() %></td>
	                                    <td><a href="auditorHistory.jsp?searchUserID=<%= list.get(i).getUserid() %>">보기</a></td>  
	                                    <td align="center">
	                                    <button type="button" onclick="updateRfpuser(<%= list.get(i).getRfpuserlistid() %>);" class="btn-xs btn-success" >수정</button> &nbsp;
	                                    <button type="button" onclick="deleteRfpuser(<%= list.get(i).getRfpuserlistid() %>);" class="btn-xs btn-danger" >삭제</button>
	                                    <%-- <a href="deleteRfpuserlistAction.jsp?rfpuserlistid=<%= list.get(i).getRfpuserlistid() %>" class="btn-xs btn-danger">삭제</a> --%>
	                                    </td>
	                                    
	                                </tr>
	                        <%
	                            }
	                        %>
	                            </tbody>
	                            </table>
		                        <input type="button"  onclick="openSelectUser()" class="btn btn-primary btn-sm pull-right" value="사람 추가">
	                            <input type="hidden" name="rfpuserlistid" value="">
	                            <input type="hidden" name="auditfield" value="">
	                    
	                    </div>
	                    

                    </form>
                </div>
             </div>
           </div>
        </div>
    </div>
    <script type="text/javascript">
        var openWin;
        
        function openSelectUser(){
        	//alert("a");
        	openWin =  window.open("./addRfpUser.jsp?rfpid=<%= rfpid %>","childForm", "width=650, height=800, resizable = yes, scrollbars = yes" );
        }
   
        function updateRfpuser(Rfpuserlistid){
            var auditField =$("#"+Rfpuserlistid).val();
            
            document.myform2.rfpuserlistid.value = Rfpuserlistid;
            document.myform2.auditfield.value = auditField;
            
            $("#myform2").attr('action', 'updateRfpuserlistAction.jsp'); //
            $("#myform2").submit();
        }
        
        //사용자 삭제 
        function deleteRfpuser(Rfpuserlistid){
            
            document.myform2.rfpuserlistid.value = Rfpuserlistid;
            
            $("#myform2").attr('action', 'deleteRfpuserlistAction.jsp'); //
            $("#myform2").submit();
        }
        
        //Rfp
        function updateRfp(){
           
            $("#myform2").attr('action', 'updateRfp.jsp'); //
            $("#myform2").submit();
        }
        
        //사용자 삭제 
        function deleteRfp(){
            
        	if(confirm("제안 인력 정보까지 모두 삭제됩니다. 삭제하시겠습니까?")){
                
                $("#myform2").attr('action', 'deleteRfpAction.jsp'); //
                $("#myform2").submit();
        	}

        }
        
        
        
        
</script>
    
</body>
    
    
    
    
    
    
    

</html>