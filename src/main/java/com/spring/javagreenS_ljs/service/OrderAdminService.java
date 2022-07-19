package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface OrderAdminService {

	public ArrayList<OrderListVO> getOrderList(int startIndexNo, int pageSize);

	public ArrayList<OrderListVO> getOrderInfor(int idx);

	public void setOrderAdminMemo(int idx, String memo);

	public void setOrderCodeChange(int idx, String code);

}
