package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.OrderAdminDAO;
import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.vo.OrderListVO;

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
}
