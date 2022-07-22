package com.spring.javagreenS_ljs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.vo.OrderListVO;

@Controller
@RequestMapping("/excel")
public class ExcelController {
	
	@Autowired
	OrderAdminService orderAdminService;
	
	
	@RequestMapping(value = "/deliveryDownload", method = RequestMethod.GET)
	public void DeliveryDownloadGet(HttpServletResponse response, HttpSession session, String company) throws IOException {
	  //Workbook wb = new HSSFWorkbook();
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("송장입력 시트");
      Row row = null;
      Cell cell = null;
      int rowNum = 0;
      
      //Header1
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("※ 주문번호가 같은 상품은 동일한 송장번호를 입력하세요.");
      
      // Header2
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("번호");
      cell = row.createCell(1);
      cell.setCellValue("주문 목록 번호");
      cell = row.createCell(2);
      cell.setCellValue("주문 번호");
      cell = row.createCell(3);
      cell.setCellValue("상품명");
      cell = row.createCell(4);
      cell.setCellValue("옵션명");
      cell = row.createCell(5);
      cell.setCellValue("수량");
      cell = row.createCell(6);
      cell.setCellValue("수취인명");
      cell = row.createCell(7);
      cell.setCellValue("수취인 연락처");
      cell = row.createCell(8);
      cell.setCellValue("배송지(우편번호)");
      cell = row.createCell(9);
      cell.setCellValue("배송지(주소)");
      cell = row.createCell(10);
      cell.setCellValue("배송지(상세주소)");
      cell = row.createCell(11);
      cell.setCellValue("배송지(참고항목)");
      cell = row.createCell(12);
      cell.setCellValue("배송메세지");
      cell = row.createCell(13);
      cell.setCellValue("택배사");
      cell = row.createCell(14);
      cell.setCellValue("송장번호");

      //주문 확인 정보만 가져오기(+ 배송지 정보 함께)
      ArrayList<OrderListVO> orderList = orderAdminService.getOrderListWithDelivery();
      
      // Body
      for (int i=0; i<orderList.size(); i++) {
          row = sheet.createRow(rowNum++);
          cell = row.createCell(0);
          cell.setCellValue(i);
          cell = row.createCell(1);
          cell.setCellValue(orderList.get(i).getOrder_list_idx());
          cell = row.createCell(2);
          cell.setCellValue(orderList.get(i).getOrder_number());
          cell = row.createCell(3);
          cell.setCellValue(orderList.get(i).getItem_name());
          cell = row.createCell(4);
          cell.setCellValue(orderList.get(i).getOption_name());
          cell = row.createCell(5);
          cell.setCellValue(orderList.get(i).getOrder_quantity());
          cell = row.createCell(6);
          cell.setCellValue(orderList.get(i).getDelivery_name());
          cell = row.createCell(7);
          cell.setCellValue(orderList.get(i).getDelivery_tel());
          cell = row.createCell(8);
          cell.setCellValue(orderList.get(i).getPostcode());
          cell = row.createCell(9);
          cell.setCellValue(orderList.get(i).getRoadAddress());
          cell = row.createCell(10);
          cell.setCellValue(orderList.get(i).getDetailAddress());
          cell = row.createCell(11);
          cell.setCellValue(orderList.get(i).getExtraAddress());
          cell = row.createCell(12);
          cell.setCellValue(orderList.get(i).getMessage());
          cell = row.createCell(13);
          cell.setCellValue(company);
          cell = row.createCell(14);
          cell.setCellValue("");
      }

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      
      //response.setHeader("Content-Disposition", "attachment;filename=example.xls");
      response.setHeader("Content-Disposition", "attachment;filename=theGarden_excel_form.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
}
