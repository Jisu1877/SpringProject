package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface DeliveryService {

	public UserDeliveryVO getDeliveryList(int user_idx);

	public void setDeliveryInfor(UserDeliveryVO vo);

}
