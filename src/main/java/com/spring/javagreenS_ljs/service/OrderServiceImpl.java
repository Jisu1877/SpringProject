package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Override
	public void setOrderListTempInsert(OrderVO orderVO, int user_idx) {
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
		String[] order_item_image = orderVO.getOrder_item_image();
		int[] order_item_price = orderVO.getOrder_item_price();
		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
		String[] order_option_idx = orderVO.getOrder_option_idx();
		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_option_price = orderVO.getOrder_option_price();
		String[] order_quantity = orderVO.getOrder_quantity();
		
		for(int i = 0; i < order_item_idx.length; i++) {
			OrderListVO vo = new OrderListVO();
			vo.setUser_idx(user_idx);
			int item_idx = Integer.parseInt(order_item_idx[i]);
			int option_idx = 0;
			if(!order_option_idx[i].equals("")) {
				option_idx = Integer.parseInt(order_option_idx[i]);
			}
			int quantity = Integer.parseInt(order_quantity[i]);
			vo.setItem_idx(item_idx);
			vo.setItem_name(order_item_name[i]);
			vo.setItem_image(order_item_image[i]);
			vo.setItem_price(order_item_price[i]);
			vo.setItem_option_flag(order_item_option_flag[i]);
			vo.setOption_idx(option_idx);
			vo.setOption_name(order_option_name[i]);
			vo.setOption_price(order_option_price[i]);
			vo.setOrder_quantity(quantity);
			
			orderDAO.setOrderListTempInsert(vo);
		}
	}

	@Override
	public ArrayList<OrderListVO> getOrderListTempList(int user_idx) {
		return orderDAO.getOrderListTempList(user_idx);
	}

	@Override
	public void setOrderListTempDelete(int user_idx) {
		orderDAO.setOrderListTempDelete(user_idx);
	}

}
