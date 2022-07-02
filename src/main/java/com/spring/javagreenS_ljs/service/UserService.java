package com.spring.javagreenS_ljs.service;

import com.spring.javagreenS_ljs.vo.UserVO;

public interface UserService {

	public UserVO getUserInfor(String user_id);

	public void setUserJoin(UserVO vo);

	public void setUserLoginUpdate(String user_id);

}
