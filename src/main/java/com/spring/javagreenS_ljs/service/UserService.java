package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.CouponVO;
import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserService {

	public UserVO getUserInfor(String user_id);

	public void setUserJoin(UserVO vo);

	public void setUserLoginUpdate(String user_id);

	public void setUserLog(int user_idx, String host_ip);

	public void setUserImageChange(MultipartHttpServletRequest multipart, int user_idx);

	public void setUserNameUpdate(int user_idx, String name);

	public void setUserEmailUpdate(int user_idx, String email);

	public void setUserTelUpdate(int user_idx, String tel);

	public void setUserGenderUpdate(int user_idx, String gender);

	public void setUserPwdUpdate(int user_idx, String encPwd);

	public UserVO getUserInforIdx(int user_idx);

	public void setCouponInsertFirstBuy(int user_idx, int coupon_idx);

	public ArrayList<CouponVO> getUserCouponList(int user_idx);

	public ArrayList<CouponVO> getUserCouponListOnlyUseOk(int user_idx);

	public void setUserGivePoint(int user_idx, int point);
	
	public void setMyPage(UserVO userVO, Model model);

	public int getUserLevel(int user_idx);

}
