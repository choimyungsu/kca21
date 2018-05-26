package com.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.pms.Edu;


public class EduExcelReader {
	
	/**
	 * XLSX �뾽濡쒕뱶 List<Examlist> 
	 * @param filePath
	 * @return
	 */
	public List<Edu> xlsxToDB(String filePath) {
		// 諛섑솚�븷 媛앹껜瑜� �깮�꽦
		List<Edu> list = new ArrayList<Edu>();
		
		FileInputStream fis = null;
		XSSFWorkbook workbook = null;
		
		try {
			
			fis= new FileInputStream(filePath);
			// HSSFWorkbook�� �뿊���뙆�씪 �쟾泥� �궡�슜�쓣 �떞怨� �엳�뒗 媛앹껜 
			workbook = new XSSFWorkbook(fis);
			
			// �깘�깋�뿉 �궗�슜�븷 Sheet, Row, Cell 媛앹껜
			XSSFSheet curSheet;
			XSSFRow   curRow;
			XSSFCell  curCell;
			Edu vo;
			
			// Sheet �깘�깋 for 臾�
			for(int sheetIndex = 0 ; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// �쁽�옱 Sheet 諛섑솚
				curSheet = workbook.getSheetAt(sheetIndex);
				// row �깘�깋 for臾�
				for(int rowIndex=0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0�� �뿤�뜑�젙蹂댁씠湲� �븣臾몄뿉 臾댁떆
					if(rowIndex != 0) {
						// �쁽�옱 row 諛섑솚
						curRow = curSheet.getRow(rowIndex);
						vo = new Edu();
						String value;
						
						// row�쓽 泥ル쾲吏� cell媛믪씠 鍮꾩뼱�엳吏� �븡�� 寃쎌슦 留� cell�깘�깋
						if(!"".equals(curRow.getCell(0).getStringCellValue())) {
							
							// cell �깘�깋 for 臾�
							for(int cellIndex=0;cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
								curCell = curRow.getCell(cellIndex);
								
								if(true) {
									value = "";
									// cell �뒪���씪�씠 �떎瑜대뜑�씪�룄 String�쑝濡� 諛섑솚 諛쏆쓬
									switch (curCell.getCellType()){
					                case HSSFCell.CELL_TYPE_FORMULA:
					                	value = curCell.getCellFormula();
					                    break;
					                case HSSFCell.CELL_TYPE_NUMERIC:
					                	value = curCell.getNumericCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_STRING:
					                    value = curCell.getStringCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_BLANK:
					                    value = curCell.getBooleanCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_ERROR:
					                    value = curCell.getErrorCellValue()+"";
					                    break;
					                default:
					                	value = new String();
										break;
					                }
									
									// �쁽�옱 column index�뿉 �뵲�씪�꽌 vo�뿉 �엯�젰
									switch (cellIndex) {
									case 0: // userid
										vo.setUserid(value);
										break;
										// period	careerDesc	task	similarCareer

									case 1: // eduDesc
										vo.setEdudesc(value);
										break;
										
									case 2: // eduTime
										vo.setEdutime(value);
										break;
										
									case 3: // eduPeriod
										vo.setEduperiod(value);
										break;
									
									case 4: // eduAgency
										vo.setEduagency(value);
										break;
										
																	
										
									default:
										break;
									}
								}
							}
							// cell �깘�깋 �씠�썑  vo 異붽�
							list.add(vo);
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} finally {
			try {
				// �뜝�럡�뀬�뜝�럩�뮔�뜝�럥由� �뜝�럩�겱�뜝�럩�쐸�뜝�룞�삕 finally�뜝�럥�뱺�뜝�럡�맋 �뜝�럥�돵�뜝�럩�젷
				if( workbook!= null) workbook.close();
				if( fis!= null) fis.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	
}
