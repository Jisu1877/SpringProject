package com.spring.javagreenS_ljs.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.CategoryDAO;
import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

@Service
public class ItemAdminServiceImpl implements ItemAdminService {
	
	@Autowired
	ItemDAO itemDAO;
	
	@Autowired
	CategoryDAO categoryDAO;
	
	//상품등록처리
	@Override
	public void setItemInsert(ItemVO itemVO, MultipartHttpServletRequest multipart) {
		int cnt = 0;
		//변수선언
		String[] Option_names = null;
		String[] Option_prices = null;
		String[] Option_stocks = null;
		String[] Option_sold_out = null;
		//idx 최대 값 구해오기
		int maxIdx = 1;
		
		ItemVO itemVO2 = itemDAO.getItemMaxIdx();
		if(itemVO2 != null) {
			maxIdx = itemVO2.getItem_idx() + 1;
		}
		itemVO.setItem_idx(maxIdx); //등록할 idx set 처리
		
		//item_code 만들기(대분류코드_중분류Idx_itemIdx)
		//대분류 코드 가져오기
		String CategoryCode = categoryDAO.getCategoryGroupCode(itemVO.getCategory_group_idx());
		//코드 만들어서 set 시키기
		String item_code = CategoryCode + "_" + itemVO.getCategory_idx() + "_" + maxIdx;
		itemVO.setItem_code(item_code);
		
		//옵션을 사용할 경우 처리작업들..
		if(itemVO.getItem_option_flag().equals("y")) {
			//option재고수량 체크
			Option_names = itemVO.getOption_name().split("/");
			Option_prices = itemVO.getStr_option_price().split("/");
			Option_stocks = itemVO.getStr_option_stock_quantity().split("/");
			Option_sold_out = new String[Option_stocks.length];
			int OptionStock = 0;
			
			for(String option_stock : Option_stocks) {
				if(option_stock.equals("0")) {
					Option_sold_out[cnt] = "1";
				}
				else {
					Option_sold_out[cnt] = "0";
				}
				OptionStock += Integer.parseInt(option_stock);
				cnt++;
			}
			itemVO.setStock_quantity(OptionStock);
			
		}
		
		//품절여부 체크
		if(itemVO.getStock_quantity() == 0) {
			itemVO.setSold_out("1");
		}
		else if(itemVO.getStock_quantity() > 0){
			itemVO.setSold_out("0");
			itemVO.setStock_schedule_date("");
		}
		else { //만약 음수값이 들어온다면..
			itemVO.setSold_out("1");
		}
		
		//itemVO DB 저장
		itemDAO.setItemInsert(itemVO);
		
		//사진 자료 서버에 올리기(저장한 ga_item idx알아와서 DB도 저장)
		ItemImageVO itemImageVO = new ItemImageVO();
		String ItemImage = setItemImage(multipart, itemImageVO, maxIdx);
		
		//대표사진 이미지 경로 set 시키기
		itemDAO.setItemImageChange(ItemImage, maxIdx); 
		
		//itemOption DB 저장
		if(itemVO.getItem_option_flag().equals("y")) {
			for(int i = 0; i<cnt; i++) {
				itemDAO.setItemOption(maxIdx,Option_names[i],Option_prices[i],Option_stocks[i],Option_sold_out[i]);
			}
		}
		
		//itemNotice DB 저장
		itemDAO.setItemNotice(maxIdx, itemVO);
	}

	
	public String setItemImage(MultipartHttpServletRequest multipart, ItemImageVO vo, int maxIdx) {
		String ItemImage = "";
		try {
			List<MultipartFile> fileList = multipart.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int cnt = 0;
			
			//비어있는 파일이 있다면 remove 처리하기
			for(int i=0; i<fileList.size(); i++) {
				if(fileList.get(i).getOriginalFilename().equals("")) {
					fileList.remove(i);
				}
			}
			
			for(MultipartFile file : fileList) {
				cnt++;
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
				
				if(cnt == 1) {
					ItemImage = sFileName; //첫번째 사진인 대표사진명 저장.
				}
				
				//서버에 파일 저장처리하기
				writeFile(file, sFileName);
				
				//item_image DB저장
				if(!oFileName.equals("")) {
					itemDAO.setItemImage(maxIdx, sFileName);
				}
			}
			
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return ItemImage;
	}
	
	
	//저장되는 파일명의 중복을 방지하기 위해 새로 파일명을 만들어준다.
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		fileName += sdf.format(date) + "_" + oFileName;
		
		return fileName;
	}
	
	//서버에 파일 저장하기
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes(); //넘어온 객체를 byte 단위로 변경시켜줌.
		
		//request 객체 꺼내오기.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		//실제로 업로드되는 경로를 찾아오기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/item/");
		//이 경로에 이 파일이름으로 저장할 껍데기 만들기
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		fos.write(data); //내용물 채우기
		fos.close();
	}
	
	
	
	// 상품의 상세설명 글을 등록 / 수정 할때 사용하는 메소드.
	@Override
	public void imgCheck(String content) {
		//                1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS_ljs/data/ckeditor/220706101701_Geoff2.jpg" style="height:1217px; width:972px" />
		// <img src="/javagreenS/data/ckeditor/220622152317_na3.png" style="height:1217px; width:972px" />
		
		//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 35;  //src="/javagreenS/data/ckeditor/ 이 해당 경로가 어떻게 될지 모르기에 실제 파일명이 시작되는 index번호를 세서 작성한다.
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			//복사한 사진 저장할 경로
			String copyFilePath = uploadPath + "itemContent/" + imgFileName;
			
			fileCopy(oFilePath,copyFilePath); //board폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//실제 서버에(ckeditor) 저장되어 있는 파일을 itemContent폴더로 복사처리한다.
	public void fileCopy(String oFilePath, String copyFilePath) {
		File oFile = new File(oFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oFile); //꺼내기
			FileOutputStream fos = new FileOutputStream(copyFile); //저장할 껍데기 만들기
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count); 
			}
			
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	@Override
	public ArrayList<ItemVO> getItemSearch(String searchString, String item_name) {
		return itemDAO.getItemSearch(searchString, item_name);
	}


	@Override
	public ArrayList<ItemVO> getItemAllInforOnlyDisplay() {
		return itemDAO.getItemAllInforOnlyDisplay();
	}


	@Override
	public ArrayList<ItemVO> getItemList() {
		return itemDAO.getItemList();
	}


	@Override
	public ItemVO getItemSameSearch(String searchString, String searchValue) {
		return itemDAO.getItemSameSearch(searchString,searchValue);
	}


	@Override
	public ArrayList<ItemOptionVO> getItemOptionInfor(int item_idx) {
		return itemDAO.getItemOptionInfor(item_idx);
	}


	@Override
	public ArrayList<ItemImageVO> getItemImageInfor(int item_idx) {
		return itemDAO.getItemImageInfor(item_idx);
	}
}
