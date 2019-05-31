<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rfp.RfpuserlistDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
   request.setCharacterEncoding("UTF-8");
   System.out.println("cms");
   System.out.println("updateData==>"+ request.getParameter("updatedRows"));
   
   
   //response.setContentType("application/json");
   response.setCharacterEncoding("utf-8");
   // Get the printwriter object from response to write the required json object to the output stream      
    PrintWriter script = response.getWriter();
	// Assuming your json object is **jsonObject**, perform the following, it will return your json object  
			
    response.getWriter().write("{\"result\": true, \"data\" : {} }");
	/*
	String jsonObject = "{\"result\": true, \"data\" : {} }";
	script.print(jsonObject);
	script.flush();
	System.out.println(jsonObject);
	*/
   
  // response.sendRedirect("{\"result\": true,  \"data\": {} }");
   // return response;
   //response.addHeader("responseData", "{\"result\": true,  \"data\": {}   }");

/*
  return response.send({
    result: true,
    data: {}
  });
   
   */
   
%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정</title>
</head>
<body>
    <%
                
       //RfpuserlistDAO rfpuserlistDAO = new RfpuserlistDAO();
       // int result = rfpuserlistDAO.update(rfpuserlist.getRfpuserlistid(),rfpuserlist.getAuditfield());
        
                
      /* 
      PrintWriter script = response.getWriter();
      script.println("{result: true,  data: {} }");
      System.out.println(script);
      
      script.println("<script>");
      script.println("history.back()");
      script.println("</script>");                    
 */

    %>
    
</body>
</html>