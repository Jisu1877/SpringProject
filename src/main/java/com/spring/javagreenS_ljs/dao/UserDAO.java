package com.spring.javagreenS_ljs.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserDAO {

	public UserVO getUserInfor(@Param("user_id") String user_id);

	public void setUserJoin(@Param("vo") UserVO vo);

	public void setUserLoginUpdate(@Param("user_id") String user_id);

	public void setUserLog(@Param("user_idx") int user_idx,@Param("host_ip") String host_ip);

}
