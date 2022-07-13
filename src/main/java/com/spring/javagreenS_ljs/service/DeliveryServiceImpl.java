package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.DeliveryDAO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

@Service
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	DeliveryDAO deliveryDAO;
	
	@Override
	public UserDeliveryVO getDeliveryList(int user_idx) {
		return deliveryDAO.getDeliveryList(user_idx);
	}

	@Override
	public void setDeliveryInfor(UserDeliveryVO vo) {
		deliveryDAO.setDeliveryInfor(vo);
	}

}
