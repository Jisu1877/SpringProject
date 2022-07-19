package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.OrderAdminDAO;
import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

@Service
public class OrderAdminServiceImpl implements OrderAdminService {
	
	@Autowired
	OrderDAO orderDAO;
	
	@Autowired
	OrderAdminDAO orderAdminDAO;

	@Override
	public ArrayList<OrderListVO> getOrderList(int startIndexNo, int pageSize) {
		return orderAdminDAO.getOrderList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<OrderListVO> getOrderInfor(int idx) {
		return orderAdminDAO.getOrderInfor(idx);
	}

	@Override
	public void setOrderAdminMemo(int idx, String memo) {
		orderAdminDAO.setOrderAdminMemo(idx,memo);
	}

	@Override
	public void setOrderCodeChange(int idx, String code) {
		orderAdminDAO.setOrderCodeChange(idx,code);
	}
}
