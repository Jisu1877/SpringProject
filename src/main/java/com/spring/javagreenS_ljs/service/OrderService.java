package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;

public interface OrderService {

	public void setOrderListTempInsert(OrderVO orderVO, int user_idx);

	public ArrayList<OrderListVO> getOrderListTempList(int user_idx);

	public void setOrderListTempDelete(int user_idx);

	public void setOrder_total_amount_and_point(int user_idx, int total_amount, int point);

	public void setOrderProcess(String user_id, int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(int user_idx);

	public ArrayList<OrderListVO> getOrderList(int user_idx);


}
