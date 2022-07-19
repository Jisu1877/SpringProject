package com.spring.javagreenS_ljs.service;

import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface DeliveryService {

	public UserDeliveryVO getDeliveryList(int user_idx);

	public void setDeliveryInfor(UserDeliveryVO vo);

	public UserDeliveryVO getUserDeliveryInfor(int delivery_idx);

}
