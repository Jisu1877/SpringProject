package com.spring.javagreenS_ljs.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;

@Service
public class ItemAdminServiceImpl implements ItemAdminService {
	
	@Autowired
	ItemDAO itemDAO;

	@Override
	public void setItemImage(MultipartHttpServletRequest multipart, ItemImageVO vo) {
		try {
			List<MultipartFile> fileList = multipart.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			int cnt = 0;
			
			for(MultipartFile file : fileList) {
				cnt++;
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
				
				//서버에 파일 저장처리하기
				writeFile(file, sFileName);
				
				fileSizes += file.getSize();
			}
			
			//DB저장(cnt 만큼 for반복문 돌면서 DB저장
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
		//저장되는 파일명의 중복을 방지하기 위해 새로 파일명을 만들어준다.
		private String saveFileName(String oFileName) {
			String fileName = "";
			
			Calendar cal = Calendar.getInstance();
			fileName += cal.get(Calendar.YEAR);
			fileName += (cal.get(Calendar.MONTH) + 1);
			fileName += cal.get(Calendar.DATE);
			fileName += cal.get(Calendar.HOUR);
			fileName += cal.get(Calendar.MINUTE);
			fileName += cal.get(Calendar.SECOND);
			fileName += cal.get(Calendar.MILLISECOND);
			fileName += "_" + oFileName;
			
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
}
