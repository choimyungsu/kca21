<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rfp.RfpuserlistDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정</title>
</head>
<body>
	<%
		
	//세션 확인
    String userID = null;
    if(session.getAttribute("userID") !=null ){
        userID = (String) session.getAttribute("userID");
    }
    
    Integer rfpid=0 ;
    if(request.getParameter("rfpid") !=null){
    	rfpid = Integer.parseInt(request.getParameter("rfpid"));
    }
    
    //자바 스크립트에 배열값을 자바 값으로 받을때..
    String ArrayCheck = "";
    if(request.getParameter("ArrayCheck") !=null){
    	ArrayCheck = request.getParameter("ArrayCheck");
    }
    
    String[] ArrayCheckValue = ArrayCheck.split(",");

    
        if(userID ==null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert(' 로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }else{
        	
        	// for 문 돌면서 입력 
	       	RfpuserlistDAO rfpuserlistDAO = new RfpuserlistDAO();
	           		
	       	for(int i =0 ; i < ArrayCheckValue.length; i++){		
	       		 
	       		rfpuserlistDAO.insert(rfpid,ArrayCheckValue[i] );
	       	}
	       	//out.println("정상적으로 업로드 하였습니다.");
	       	PrintWriter script = response.getWriter();
	       	script.println("<script>");
	       	script.println("alert(' 정상적으로 등록 하였습니다.');");
	       	script.println("opener.parent.location.href ='viewRfp.jsp?rfpid="+rfpid+"'");
	       	script.println("window.close();");
	       	script.println("</script>");
        }


	%>
	
</body>
</html>