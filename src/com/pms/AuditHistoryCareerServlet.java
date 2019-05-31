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
@WebServlet("/AuditHistoryCareerServlet")
public class AuditHistoryCareerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// ����� ������ ó��
		String updatedRowsJson = request.getParameter("updatedRows");
		CareerDAO  careerDAO = new CareerDAO();
		JSONParser parser = new JSONParser();
		
		if(updatedRowsJson != null) {
			updatedRowsJson = "{\"updatedRows\":" + updatedRowsJson +"}";
			System.out.println("servlet updatedRowsJson==>"+ updatedRowsJson);
			
			try {
				JSONObject univ = (JSONObject)parser.parse(updatedRowsJson);
				JSONArray arr = (JSONArray)univ.get("updatedRows"); // updatedRows�̸����� �� JSON������Ʈ��  Array���·� ����
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					Integer careerID = Integer.parseInt((String)tmp.get("careerID"));
					String careerDesc = (String)tmp.get("careerDesc");
					String period = (String)tmp.get("period");
					String task = (String)tmp.get("task");
					String similarCareer = (String)tmp.get("similarCareer");
					String biz = (String)tmp.get("biz");
					String app = (String)tmp.get("app");
					String db = (String)tmp.get("db");
					String archi = (String)tmp.get("archi");
					String userID = (String)tmp.get("userID");
					careerDAO.update(careerID,careerDesc,period,task,similarCareer,biz,app,db,archi,userID);// ������Ʈ
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// ������ ������ ó��
		String createdRowsJson = request.getParameter("createdRows");
		
		if(createdRowsJson != null) {
			createdRowsJson = "{\"createdRows\":" + createdRowsJson +"}";
			System.out.println("servlet createdRows==>"+ createdRowsJson);
			try {
				JSONObject univ = (JSONObject)parser.parse(createdRowsJson);
				JSONArray arr = (JSONArray)univ.get("createdRows"); // createdRows�̸����� �� JSON������Ʈ��  Array���·� ����
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					String careerDesc = (String)tmp.get("careerDesc");
					String period = (String)tmp.get("period");
					String task = (String)tmp.get("task");
					String similarCareer = (String)tmp.get("similarCareer");
					String biz = (String)tmp.get("biz");
					String app = (String)tmp.get("app");
					String db = (String)tmp.get("db");
					String archi = (String)tmp.get("archi");
					String userID = request.getParameter("userID"); // �̰��� ������ �Ѱ��־�� �Ѵ�..
					
					careerDAO.insertExcel(userID,period,careerDesc,task,similarCareer,biz,app,db,archi);// ������Ʈ
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// ������ ������ ó��
		String deletedRowsJson = request.getParameter("deletedRows");
		if(deletedRowsJson != null) {
			deletedRowsJson = "{\"deletedRows\":" + deletedRowsJson +"}";
			System.out.println("servlet deletedRows==>"+ deletedRowsJson);
			try {
				JSONObject univ = (JSONObject)parser.parse(deletedRowsJson);
				JSONArray arr = (JSONArray)univ.get("deletedRows"); // deletedRows�̸����� �� JSON������Ʈ��  Array���·� ����
				System.out.println("arr.size()="+arr.size());
				for(int i=0;i<arr.size();i++) {
					JSONObject tmp = (JSONObject)arr.get(i);
					Integer careerID = Integer.parseInt((String)tmp.get("careerID"));
					careerDAO.delete(careerID);
				}
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		response.setContentType("text/hteml;charset=UTF-8");
		//String level1 = request.getParameter("level1");
		response.getWriter().write("{\"result\": true, \"data\" : {} }"); // TOAST GRID�� ����� ���������� �Ǿ��ٰ� ����� �ڵ�..
	}

}

