package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OrderListVO;

public interface OrderAdminService {

	public ArrayList<OrderListVO> getOrderList(int startIndexNo, int pageSize);

}
