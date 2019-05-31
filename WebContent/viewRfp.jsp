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
<link rel="stylesheet" type="text/css" href="css/tui-example-style.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<title>변경</title>
</head>
<body>


<jsp:include page="header.jsp" flush="true" />

<!-- TOAST UI 적용  2019.01.03 CDN 적용 start 위치 중요!! jquery 밑으로.. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.3.3/backbone.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
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
	                    <% 
	                      
	                        String jsonString = new RfpuserlistDAO().getListJSON(rfpid);
	                    
	                    %>
	                    <%-- <%= jsonString  %> --%>
	                    <div id="grid"></div>
	                    <div id="paginextr" style="float:right; margin-top:20px;"></div>
                        <div id="pagination" class="tui-pagination"></div>
	                    <input type="button"  onclick="fn_add()" class="btn btn-primary btn-sm" value="행추가">
	                    <input type="button"  onclick="fn_copy()" class="btn btn-primary btn-sm" value="행복사">
	                    <input type="button"  onclick="fn_remove()" class="btn btn-primary btn-sm" value="행삭제">
	                    <input type="button"  onclick="fn_save()" class="btn btn-primary btn-sm" value="저장">
	                    <input type="button"  onclick="fn_delete2()" class="btn btn-primary btn-sm" value="삭제">

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
        
      
        
        /* 2019.01.03 toast 관련 추가 시작 */
        
        


        /* jquery 사용시 활용 */
        function goJquery2(doUrl, formData, type, callback){
            //alert(doUrl);
            
            //formData += "&insert_user=&insert_user_name="; 
            
            $.ajax({
                method: type,
                url: doUrl,
                data: formData,
                beforeSend: function( xhr ) {
                    //xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
                    hideShowColumn('hide');
                }
            })
            .done(function( msg ) {
                if( msg != null ){
                    
                    //hideShowColumn('hide');
                    
                    if( JSON.parse(msg).msg != null ){              
                        alert( JSON.parse(msg).msg );
                    }
                    if( JSON.parse(msg).process == "success" ){
                        goSearch();
                    }
                    if( JSON.parse(msg).rows != null ){
                        //gridData = JSON.stringify(JSON.parse(msg).rows);
                        //alert(msg);
                        //alert(JSON.parse(msg).rows[0]);
                        gridData = JSON.parse(msg).rows;
                        //alert(gridData);
                        //alert(JSON.parse(msg).paginationInfo.totalRecordCount);
                        $('#rows').val(JSON.parse(msg).paginationInfo.recordCountPerPage);
                        $('#page').val(JSON.parse(msg).paginationInfo.currentPageNo);
                        $('#totalCnt').val(JSON.parse(msg).paginationInfo.totalRecordCount);
                    }
                }
                
                if(typeof callback === 'function') {
                    callback();
                }
            });
        }

        function goExcel(){
            //document.form1.action = "/grid/excelData2.do";
            //document.form1.submit();
            
            $('.wrap-loading').removeClass('display-none');
            setTimeout("goExcel2();", 1000);
            setTimeout("goExcel3();", $('#totalCnt').val()/9*2);
        }
        function goExcel2(){    
            document.form1.action = "/grid/excelData2.do";
            document.form1.submit();
            
            //var form = "<form id='xlsForm' action=\"/grid/excelData2.do\" method='post'>";
            //form += "</form>"; 
            //jQuery(form).appendTo("body").submit().remove();
        }
        function goExcel3(){    
            $('.wrap-loading').addClass('display-none');
        }

        function fn_save2(){    
            
            if( !grid.isModified() ){
                alert("저장할 데이터가 없습니다.");
                return false;
            }
            
            if( !fn_check() ){
                return false;
            }

            if(!confirm("저장하시겠습니까?")){
                return false;
            }
             
            $('.wrap-loading').removeClass('display-none');
            hideShowColumn('show');
            var url = "/grid/gridSaveBatch.do";
            goJquery2(url,$("#searchVO").serialize(),'post', function(){
                $('.wrap-loading').addClass('display-none');
            });
        }

        function fn_check(){
            
            var ids = grid.getRows();
            //alert(ids.length);
           
            for(var i=0; i<ids.length; i++){
                if( ids[i].selectline != 'A' && ids[i].selectline != 'M' ){
                    continue;
                }
                
                if( ids[i].inout == '' ){
                    alert("입출고구분은 필수항목입니다.");
                    grid.focus(i,'inout');
                    return false;
                }
                
                if( ids[i].ymd == '' ){
                    alert("일자는 필수항목입니다.");
                    grid.focus(i,'ymd');
                    return false;
                }
                
                if( ids[i].num == '' ){
                    alert("번호는 필수항목입니다.");
                    grid.focus(i,'num');
                    return false;
                }
            }
            
            return true;
        }

        
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
        	
       	  grid.use('Net', {
       	        //perPage: 3,
       	        updateDataMethod: 'POST',
       	        api: {
       	            //updateData: 'updateTest.jsp' // url 
       	            updateData: './RfpuserRegServlet' // 서블릿으로 변경
       	        }
       	    });
       	  
        	var net = grid.getAddOn('Net');
        	net.request('updateData'); // Send a request to '/api/updateData'
        	
        	//alert(net.request('updateData'));
        	
        }



        
        /* 2019.01.03 toast 관련 추가 끝 */
        
</script>
 <script type="text/javascript">

  var grid = new tui.Grid({
      el: $('#grid'),
      scrollX: false,
      scrollY: false,
      rowHeaders: ['checkbox'],//체크박스 추가
      pagination: true,
      columns: [
          {
              title: '아이디',
              name: 'userID',
          },
          {
              title: '이름',
              name: 'userName',
          },
          {
              title: '감리원번호',
              name: 'auditNo',
          },
          {
              title: '총감리건수',
              name: 'cnt',
          },
          {
              title: '담당영역',
              name: 'auditField',
              
              editOptions: {
                  type: 'text',
                  maxLength: 10,
                  useViewMode: false
              }
          }
      ]
  });
  
  
  //gridData :json 형태 값  
  var json = <%= jsonString  %> ; // 아래와 같은 형태로 반환됨.그래서 gridData 값만 추출이 필요함.
  //{"gridData":[{"userID":"aoj","rfpUserListID":"12","cnt":"2","eduTime":"","auditField":"총괄'감리원","auditNo":"","userName":"안옥정","rfpID":"3"},{"userID":"cms","rfpUserListID":"13","cnt":"45","eduTime":"95","auditField":"응용","auditNo":"정감협 제1767호","userName":"최명수","rfpID":"3"},{"userID":"bjhbc","rfpUserListID":"14","cnt":"0","eduTime":"","auditField":"","auditNo":"","userName":"백준환","rfpID":"3"},{"userID":"bscho","rfpUserListID":"15","cnt":"0","eduTime":"","auditField":"","auditNo":"","userName":"조범순","rfpID":"3"}]}
  //var text1 = json.gridData; 
  grid.setData(json.gridData); // 값만 추출하기
  <%-- // grid.setData(<%= jsonString  %>); --%>

  
  </script>
    
</body>
    
    
    
    
    
    
    

</html>