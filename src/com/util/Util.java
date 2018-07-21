package com.util;

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

}
