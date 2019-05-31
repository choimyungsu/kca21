<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.file.LinkfileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.excel.AuditHistoryExcelReader,com.pms.AuditHistory,com.pms.AuditHistoryDAO" %>
<%@ page import="com.excel.CareerExcelReader,com.pms.Career,com.pms.CareerDAO" %>
<%@ page import="com.excel.CertiExcelReader,com.pms.Certi,com.pms.CertiDAO" %>
<%@ page import="com.excel.EduExcelReader,com.pms.Edu,com.pms.EduDAO" %>
<%@ page import="com.excel.UserExcelReader,com.user.User,com.user.UserDAO" %>
<%@ page import="com.excel.AuditReportExcelReader,com.pms.AuditReport,com.pms.AuditReportDAO" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.Context, java.util.List" %>

<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 업로드</title>
</head>
<body>
	<%
		//String directory = "C:\\JSP\\projects\\kca21\\WebContent\\excel\\"; // 로컬용
        String directory = "/home/hosting_users/kca21/www/excel/";// 운영서버 용
	
			int maxSize = 1024*1024*100;
			String encoding ="UTF-8";
			
			MultipartRequest multipartRequest = new MultipartRequest(request,directory,maxSize,encoding,new DefaultFileRenamePolicy());
			
		//파일 처리 시작

		Enumeration fileNames = multipartRequest.getFileNames();
		String path="";
		String type= multipartRequest.getParameter("type");
		String alldelete = multipartRequest.getParameter("alldelete");
		System.out.println("alldelete==>"+alldelete);

		while(fileNames.hasMoreElements()){
			
			String parameter = (String) fileNames.nextElement();
			String fileName = multipartRequest.getOriginalFileName(parameter);
			String fileRealName = multipartRequest.getFilesystemName(parameter);
			String filePath = directory;

			if(fileName == null) continue;//중간에 문서를 올리지 않은 항목에 대한 처리 
			
			if(!fileName.endsWith(".xlsx"))
			{ // 시큐어 코딩 적용( 업로드 확장자 지정)
				File file = new File(directory+fileRealName);
				file.delete();
				out.write("올릴수 없는 파일입니다.");
				
			} else {

				out.write("fileName="+ fileName +", fileRealName="+fileRealName);
				path = directory+fileRealName;
				
			}
			
			
		}
		
		//파일 처리 end 
		
if(type.equals("A")){ // 이력 업로드
    
    AuditHistoryExcelReader excelReader = new AuditHistoryExcelReader();
    List<AuditHistory> xlsxList;
    
    xlsxList = excelReader.xlsxToDB(path);//
    AuditHistoryDAO auditHistoryDAO = new AuditHistoryDAO();
    
    
    
    
    for(int i =0 ; i < xlsxList.size(); i++){
    	
    	if(alldelete!=null && alldelete.equals("on") && i==0){// 이전데이를 모두 삭제한다고 체크한 경우 해당 유저로 저장된 기록은 모두 삭제
            auditHistoryDAO.deleteAll(xlsxList.get(i).getUserid());
        }
    	
        auditHistoryDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getAudityearmonth(), xlsxList.get(i).getAuditname(), xlsxList.get(i).getMainclient(), xlsxList.get(i).getMaindivision(), xlsxList.get(i).getAuditfield(), xlsxList.get(i).getAuditrole() , xlsxList.get(i).getJoinrate()) ;
    }
    
}else if(type.equals("B")){//경력 업로드
    
    
    CareerExcelReader excelReader2 = new CareerExcelReader();
    List<Career> xlsxList;
    xlsxList = excelReader2.xlsxToDB(path);//
    CareerDAO careerDAO = new CareerDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
    	if(alldelete!=null && alldelete.equals("on") && i==0){// 이전데이를 모두 삭제한다고 체크한 경우 해당 유저로 저장된 기록은 모두 삭제
    		careerDAO.deleteAll(xlsxList.get(i).getUserid());
    	
        }
        careerDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getPeriod(), xlsxList.get(i).getCareerdesc(), xlsxList.get(i).getTask(), xlsxList.get(i).getSimilarcareer(),xlsxList.get(i).getBiz(),xlsxList.get(i).getApp(),xlsxList.get(i).getDb(),xlsxList.get(i).getArchi()) ;
    }
    
}else if(type.equals("C")){// 자격증 업로드 
    
    CertiExcelReader excelReader3 = new CertiExcelReader();
    List<Certi> xlsxList;
    
    xlsxList = excelReader3.xlsxToDB(path);//
    CertiDAO ceritDAO = new CertiDAO();
    
    for(int i =0 ; i < xlsxList.size(); i++){
    	
    	if(alldelete!=null && alldelete.equals("on") && i==0){// 이전데이를 모두 삭제한다고 체크한 경우 해당 유저로 저장된 기록은 모두 삭제
    		ceritDAO.deleteAll(xlsxList.get(i).getUserid());
        }
        ceritDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getCertiname(), xlsxList.get(i).getIssuer(), xlsxList.get(i).getCertidivision(), xlsxList.get(i).getCertifield()) ;
    }
    

    
}else if(type.equals("D")){ // 교육이수 현왕 
    
        EduExcelReader excelReader4 = new EduExcelReader();
        List<Edu> xlsxList;
        
        xlsxList = excelReader4.xlsxToDB(path);//
        EduDAO eduDAO = new EduDAO();
        
        for(int i =0 ; i < xlsxList.size(); i++){
        	if(alldelete!=null && alldelete.equals("on") && i==0){// 이전데이를 모두 삭제한다고 체크한 경우 해당 유저로 저장된 기록은 모두 삭제
        		eduDAO.deleteAll(xlsxList.get(i).getUserid());
            }
        	
            eduDAO.insertExcel( xlsxList.get(i).getUserid(), xlsxList.get(i).getEdudesc(), xlsxList.get(i).getEdutime(), xlsxList.get(i).getEduperiod(), xlsxList.get(i).getEduagency()) ;
        }
    
    
}else if(type.equals("E")){ // user 
    
     UserExcelReader excelReader5 = new UserExcelReader();
     List<User> xlsxList;
     
     xlsxList = excelReader5.xlsxToDB(path);//
     UserDAO userDAO = new UserDAO();
     
     for(int i =0 ; i < xlsxList.size(); i++){
         userDAO.join( xlsxList.get(i));
     }
    
    
}else if(type.equals("F")){ // 감리보고서
    
    AuditReportExcelReader excelReader6 = new AuditReportExcelReader();
    List<AuditReport> xlsxList;
    
    xlsxList = excelReader6.xlsxToDB(path);//
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
		
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href ='main.jsp' ");
		script.println("</script>");
		
	%>
	
</body>
</html>