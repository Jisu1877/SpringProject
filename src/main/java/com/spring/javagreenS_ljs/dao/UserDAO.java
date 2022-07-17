package com.spring.javagreenS_ljs.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserDAO {

	public UserVO getUserInfor(@Param("user_id") String user_id);

	public void setUserJoin(@Param("vo") UserVO vo);

	public void setUserLoginUpdate(@Param("user_id") String user_id);

	public void setUserLog(@Param("user_idx") int user_idx, @Param("host_ip") String host_ip);

	public void setOrderUpdate(@Param("user_idx") int user_idx, @Param("total_amount") int total_amount);

	public void setPointUseUpate(@Param("user_idx") int user_idx, @Param("point") int point);

	public void setUserImageChange(@Param("fileName") String fileName, @Param("user_idx") int user_idx);

	public void setUserNameUpdate(@Param("user_idx") int user_idx, @Param("name") String name);

	public void setUserEmailUpdate(@Param("user_idx") int user_idx, @Param("email") String email);

	public void setUserTelUpdate(@Param("user_idx") int user_idx, @Param("tel") String tel);

	public void setUserGenderUpdate(@Param("user_idx") int user_idx,@Param("gender") String gender);

	public void setUserPwdUpdate(@Param("user_idx") int user_idx,@Param("encPwd") String encPwd);

}
