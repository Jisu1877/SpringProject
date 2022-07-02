package com.spring.javagreenS_ljs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.UserDAO;
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
}
