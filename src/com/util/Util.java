package com.util;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONValue;

public class Util {
	
	public String changeStirng(String inputString) { // 
		String outputString ="";
		if(inputString == null || inputString =="" )
		{
			return outputString;
		}
		else if (inputString.equals("false")) {
			
			return outputString;
			
		}else{
			
			return inputString;
		}
	}
	
	
	public String nullconvertString(String input) { // 
		if(input == null )
		{
			return "";
		}else{
			return input ;
		}
	}
	
	public Integer nullconvertInteger (Integer input) { // 
		if(input == null )
		{
			return 0;
		}else {
			return input;
		}
	}
	
	public String cutStirng(String inputString, int cut) {
		String outputString ="";
		if(inputString == null || inputString =="" )
		{
			return outputString;
		}
		else if (inputString.length() < cut) {
			
			return changeStirng(inputString);//false 인것은 ""으로 변환
			
		}else {
			outputString = inputString.substring(0,cut) + "..." ;
		}
		
		return outputString;
	}	
	
	// Resultset을 받아서 json으로 반환하기 
	public String getJSONFromResultSet(ResultSet rs,String keyName) {
	    Map json = new HashMap(); 
	    List list = new ArrayList();
	    if(rs!=null)
	    {
	        try {
	            ResultSetMetaData metaData = rs.getMetaData();
	            while(rs.next())
	            {
	                Map<String,Object> columnMap = new HashMap<String, Object>();
	                for(int columnIndex=1;columnIndex<=metaData.getColumnCount();columnIndex++)
	                {
	                    if(rs.getString(metaData.getColumnName(columnIndex))!=null)
	                        columnMap.put(metaData.getColumnLabel(columnIndex),     rs.getString(metaData.getColumnName(columnIndex)));
	                    else
	                        columnMap.put(metaData.getColumnLabel(columnIndex), "");
	                }
	                list.add(columnMap);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        json.put(keyName, list);
	     }
	     return JSONValue.toJSONString(json);
	}	

}
