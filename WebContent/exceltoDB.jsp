<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.Context, java.util.List" %>
<%@ page import="com.excel.AuditHistoryExcelReader,com.pms.AuditHistory,com.pms.AuditHistoryDAO" %>
<%@ page import="com.excel.CareerExcelReader,com.pms.Career,com.pms.CareerDAO" %>
<%@ page import="com.excel.CertiExcelReader,com.pms.Certi,com.pms.CertiDAO" %>
<%@ page import="com.excel.EduExcelReader,com.pms.Edu,com.pms.EduDAO" %>
<%@ page import="com.excel.UserExcelReader,com.user.User,com.user.UserDAO" %>
<%@ page import="com.excel.AuditReportExcelReader,com.pms.AuditReport,com.pms.AuditReportDAO" %>

<%@ page import="java.io.PrintWriter" %>
</head>
<body>
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
    
}else if(!userID.equals("cms")){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(' 관리자가 아닙니다.')");
    script.println("location.href = 'main.jsp'");
    script.println("</script>");
    
    
}else{

String type = request.getParameter("type");
if(type.equals("A")){ // 이력 업로드
    
    AuditHistoryExcelReader excelReader = new AuditHistoryExcelReader();
    System.out.println("*****xlsx  *****");
    System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
    //List<Examlist> xlsxList = excelReader.xlsxToExamMasterList("/home/hosting_users/cms2580/www/excel/boangisa3.xlsx");// cafe24 서버 올리기 주소
    
    List<AuditHistory> xlsxList;
    
    //xlsxList = excelReader.xlsxToDB("C:\\gamliexcel\\audit_cms.xlsx");// 
    xlsxList = excelReader.xlsxToDB("/home/hosting_users/kca21/www/excel/audit_chkim.xlsx");//
    
    AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
         
    	auditHistoryDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getAudityearmonth(), xlsxList.get(i).getAuditname(), xlsxList.get(i).getMainclient(), xlsxList.get(i).getMaindivision(), xlsxList.get(i).getAuditfield(), xlsxList.get(i).getAuditrole() , xlsxList.get(i).getJoinrate()) ;
    	
    }
    
}else if(type.equals("B")){//경력 업로드
	
	
    CareerExcelReader excelReader2 = new CareerExcelReader();
    System.out.println("*****xlsx  *****");
    System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
    //List<Examlist> xlsxList = excelReader.xlsxToExamMasterList("/home/hosting_users/cms2580/www/excel/boangisa3.xlsx");// cafe24 서버 올리기 주소
    
    List<Career> xlsxList;
    
    //xlsxList = excelReader2.xlsxToDB("C:\\gamliexcel\\career_cms.xlsx");// 
    xlsxList = excelReader2.xlsxToDB("/home/hosting_users/kca21/www/excel/career_cms.xlsx");//
    
    CareerDAO careerDAO = new CareerDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
         
    	careerDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getPeriod(), xlsxList.get(i).getCareerdesc(), xlsxList.get(i).getTask(), xlsxList.get(i).getSimilarcareer(),xlsxList.get(i).getBiz(),xlsxList.get(i).getApp(),xlsxList.get(i).getDb(),xlsxList.get(i).getArchi()) ;
    	//(String userID, String period, String careerDesc, String task,String similarCareer) {
    }
	
}else if(type.equals("C")){// 자격증 업로드 
	
	CertiExcelReader excelReader3 = new CertiExcelReader();
    System.out.println("*****xlsx  *****");
    System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
    //List<Examlist> xlsxList = excelReader.xlsxToExamMasterList("/home/hosting_users/cms2580/www/excel/boangisa3.xlsx");// cafe24 서버 올리기 주소
    
    List<Certi> xlsxList;
    
    //xlsxList = excelReader3.xlsxToDB("C:\\gamliexcel\\certi_cms.xlsx");// 
    xlsxList = excelReader3.xlsxToDB("/home/hosting_users/kca21/www/excel/certi_cms.xlsx");//
    
    CertiDAO ceritDAO = new CertiDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
         
    	ceritDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getCertiname(), xlsxList.get(i).getIssuer(), xlsxList.get(i).getCertidivision(), xlsxList.get(i).getCertifield()) ;
        //insertExcel(String userID, String certiName, String issuer, String certiDivision,String certiField) {
    }
	

	
}else if(type.equals("D")){ // 교육이수 현왕 
	
	    EduExcelReader excelReader4 = new EduExcelReader();
	    System.out.println("*****xlsx  *****");
	    System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
	    //List<Examlist> xlsxList = excelReader.xlsxToExamMasterList("/home/hosting_users/cms2580/www/excel/boangisa3.xlsx");// cafe24 서버 올리기 주소
	    
	    List<Edu> xlsxList;
	    
	    //xlsxList = excelReader4.xlsxToDB("C:\\gamliexcel\\edu_cms.xlsx");// 
	    xlsxList = excelReader4.xlsxToDB("/home/hosting_users/kca21/www/excel/edu_cms.xlsx");//
	    
	    EduDAO eduDAO = new EduDAO();
	    
	    for(int i =0 ; i < xlsxList.size(); i++){
	         
	    	eduDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getEdudesc(), xlsxList.get(i).getEdutime(), xlsxList.get(i).getEduperiod(), xlsxList.get(i).getEduagency()) ;
	    	//insertExcel(String userID, String eduDesc, String eduTime, String eduPeriod, String eduAgency) {
	    		
	    }
	
	
}else if(type.equals("E")){ // user 
	
	 UserExcelReader excelReader5 = new UserExcelReader();
     System.out.println("*****xlsx  *****");
     System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
     
     List<User> xlsxList;
     
     //xlsxList = excelReader5.xlsxToDB("C:\\gamliexcel\\userall_test.xlsx");// 
     xlsxList = excelReader5.xlsxToDB("/home/hosting_users/kca21/www/excel/userall_test.xlsx");//
     
     UserDAO userDAO = new UserDAO();
     
     for(int i =0 ; i < xlsxList.size(); i++){
          
    	 //userDAO.join( xlsxList.get(i).getUserid(), xlsxList.get(i).getUserpassword(), xlsxList.get(i).getUsername(), xlsxList.get(i).getUseremail(), xlsxList.get(i).getUserdept(), xlsxList.get(i).getUserlevel(), xlsxList.get(i).getBirth(), xlsxList.get(i).getOrg()) ;
    	 userDAO.join( xlsxList.get(i));
             
     }
	
	
}else if(type.equals("F")){ // 감리보고서
	
    AuditReportExcelReader excelReader6 = new AuditReportExcelReader();
    System.out.println("*****xlsx  *****");
    System.out.println("*****realpath  *****"+ request.getSession().getServletContext().getRealPath("/"));
    
    List<AuditReport> xlsxList;
    
    //xlsxList = excelReader6.xlsxToDB("C:\\gamliexcel\\audit_report.xlsx");// 
    xlsxList = excelReader6.xlsxToDB("/home/hosting_users/kca21/www/excel/audit_report-1.xlsx");//
    
    AuditReportDAO auditReportDAO = new AuditReportDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
         
        auditReportDAO.insert(xlsxList.get(i));
            
    }

	
}else{
	
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert(' type 설정 오류 ')");
	script.println("location.href = 'main.jsp'");
	script.println("</script>");

}
	    
//out.println("정상적으로 업로드 하였습니다.");
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert(' 정상적으로 업로드 하였습니다.')");
script.println("location.href = 'main.jsp'");
script.println("</script>");


}
	
   
%>

</body>
</html>

