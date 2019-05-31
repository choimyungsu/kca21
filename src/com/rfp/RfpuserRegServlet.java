package com.rfp;

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
 * Servlet implementation class RfpuserRegServlet
 */
@WebServlet("/RfpuserRegServlet")
public class RfpuserRegServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//System.out.println("servlet updateData==>"+ request.getParameter("updatedRows"));
		
		String updatedRowsJson = request.getParameter("updatedRows");
		updatedRowsJson = "{\"updateUser\":" + updatedRowsJson +"}";
		System.out.println("servlet updateData==>"+ updatedRowsJson);
		
		RfpuserlistDAO  rfpuserlistDAO = new RfpuserlistDAO();
		// JSON ���·� ���� ���� �ٽ� �ɰ���  
		JSONParser parser = new JSONParser();
		try {
			JSONObject univ = (JSONObject)parser.parse(updatedRowsJson);
			JSONArray arr = (JSONArray)univ.get("updateUser"); // updateUser�̸����� �� JSON������Ʈ��  Array���·� ����
			System.out.println("arr.size()="+arr.size());
			for(int i=0;i<arr.size();i++) {
				JSONObject tmp = (JSONObject)arr.get(i);
				Integer rfpUserListID = Integer.parseInt((String)tmp.get("rfpUserListID"));
				String auditField = (String)tmp.get("auditField");
				System.out.println("rfpUserListID="+rfpUserListID);
				System.out.println("auditField="+auditField);
				
				rfpuserlistDAO.update(rfpUserListID,auditField);// ������Ʈ
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setContentType("text/hteml;charset=UTF-8");
		String level1 = request.getParameter("level1");
		response.getWriter().write("{\"result\": true, \"data\" : {} }"); // TOAST GRID�� ����� ���������� �Ǿ��ٰ� ����� �ڵ�..
	}

}
