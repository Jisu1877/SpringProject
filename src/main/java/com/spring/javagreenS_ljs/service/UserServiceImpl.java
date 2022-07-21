package com.spring.javagreenS_ljs.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.UserDAO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO userDAO;

	@Override
	public UserVO getUserInfor(String user_id) {
		return userDAO.getUserInfor(user_id);
	}

	@Override
	public void setUserJoin(UserVO vo) {
		userDAO.setUserJoin(vo);
	}

	@Override
	public void setUserLoginUpdate(String user_id) {
		userDAO.setUserLoginUpdate(user_id);
	}

	@Override
	public void setUserLog(int user_idx, String host_ip) {
		userDAO.setUserLog(user_idx, host_ip);
	}

	@Override
	public void setUserImageChange(MultipartHttpServletRequest multipart, int user_idx) {
		//서버에 파일 올리기 & DB업로드
		setItemImage(multipart, user_idx);
		
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
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/user/");
		//이 경로에 이 파일이름으로 저장할 껍데기 만들기
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		fos.write(data); //내용물 채우기
		fos.close();
	}
	
	public void setItemImage(MultipartHttpServletRequest multipart, int user_idx) {
		try {
			List<MultipartFile> fileList = multipart.getFiles("user_image");
			
			for(MultipartFile file : fileList) {
				if (file.getSize() == 0) {
					continue;
				}
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); //서버에 저장될 파일명을 결정해준다.
				//서버에 파일 저장처리하기
				writeFile(file, sFileName);
				
				//item_image DB저장
				if(!oFileName.equals("")) {
					userDAO.setUserImageChange(sFileName, user_idx);
				}
			}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void setUserNameUpdate(int user_idx, String name) {
		userDAO.setUserNameUpdate(user_idx, name);
	}

	@Override
	public void setUserEmailUpdate(int user_idx, String email) {
		userDAO.setUserEmailUpdate(user_idx,email);
	}

	@Override
	public void setUserTelUpdate(int user_idx, String tel) {
		userDAO.setUserTelUpdate(user_idx,tel);
	}

	@Override
	public void setUserGenderUpdate(int user_idx, String gender) {
		userDAO.setUserGenderUpdate(user_idx,gender);
	}

	@Override
	public void setUserPwdUpdate(int user_idx, String encPwd) {
		userDAO.setUserPwdUpdate(user_idx,encPwd);
	}

	@Override
	public UserVO getUserInforIdx(int user_idx) {
		return userDAO.getUserInforIdx(user_idx);
	}

}
