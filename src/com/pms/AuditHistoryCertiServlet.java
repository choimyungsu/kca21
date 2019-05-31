package com.pms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


/**
 * Servlet implementation class AuditHistoryServlet
 */
@WebServlet("/AuditHistoryCertiServlet")
public class AuditHistoryCertiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 변경된 데이터 처리
		String updatedRowsJson = request.getParameter("updatedRows");
		CertiDAO  certiDAO = new CertiDAO();
		JSONParser parser = new JSONParser();
		
		if(updatedRowsJson != null) {
			updatedRowsJson = "{\"updatedRows\":" + updatedRowsJson +"}";
			System.out.println("servlet updatedRowsJson==>"+ updatedRowsJson);
			
			try {
				JSONObject univ = (JSONObject)parser.parse(updatedRowsJson);
				JSONArray arr = (JSONArray)univ.get("updatedRows"); // updatedRows이름으로 된 JSON오브젝트를  Array형태로 변경
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					Integer certiID = Integer.parseInt((String)tmp.get("certiID"));
					String certiName = (String)tmp.get("certiName");
					String issuer = (String)tmp.get("issuer");
					String certiDivision = (String)tmp.get("certiDivision");
					String certiField = (String)tmp.get("certiField");
					String issueDate = (String)tmp.get("issueDate");
					String userID = (String)tmp.get("userID");
					certiDAO.update(certiID,certiName,issuer,certiDivision,certiField,issueDate,userID);// 업데이트
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// 생성된 데이터 처리
		String createdRowsJson = request.getParameter("createdRows");
		
		if(createdRowsJson != null) {
			createdRowsJson = "{\"createdRows\":" + createdRowsJson +"}";
			System.out.println("servlet createdRows==>"+ createdRowsJson);
			try {
				JSONObject univ = (JSONObject)parser.parse(createdRowsJson);
				JSONArray arr = (JSONArray)univ.get("createdRows"); // createdRows이름으로 된 JSON오브젝트를  Array형태로 변경
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					//Integer auditHistoryID = Integer.parseInt((String)tmp.get("auditHistoryID"));
					String certiName = (String)tmp.get("certiName");
					String issuer = (String)tmp.get("issuer");
					String certiDivision = (String)tmp.get("certiDivision");
					String certiField = (String)tmp.get("certiField");
					String issueDate = (String)tmp.get("issueDate");
					String userID = request.getParameter("userID"); // 이값은 별도로 넘겨주어야 한다..
					
					certiDAO.insert(userID,certiName,issuer,certiDivision,certiField,issueDate);// 
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 삭제된 데이터 처리
		String deletedRowsJson = request.getParameter("deletedRows");
		if(deletedRowsJson != null) {
			deletedRowsJson = "{\"deletedRows\":" + deletedRowsJson +"}";
			System.out.println("servlet deletedRows==>"+ deletedRowsJson);
			try {
				JSONObject univ = (JSONObject)parser.parse(deletedRowsJson);
				JSONArray arr = (JSONArray)univ.get("deletedRows"); // deletedRows이름으로 된 JSON오브젝트를  Array형태로 변경
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					Integer certiID = Integer.parseInt((String)tmp.get("certiID"));
					certiDAO.delete(certiID);
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		response.setContentType("text/hteml;charset=UTF-8");
		//String level1 = request.getParameter("level1");
		response.getWriter().write("{\"result\": true, \"data\" : {} }"); // TOAST GRID와 통신이 정상적으로 되었다고 약속한 코드..
	}

}

