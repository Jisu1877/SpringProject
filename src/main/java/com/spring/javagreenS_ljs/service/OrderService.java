package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;

public interface OrderService {

	public void setOrderListTempInsert(OrderVO orderVO, int user_idx);
	
	public void setOrderListTempInsertForBuyNow(OrderVO orderVO, int user_idx);

	public ArrayList<OrderListVO> getOrderListTempList(int user_idx);

	public void setOrderListTempDelete(int user_idx);

	public void setOrder_total_amount_and_point(int user_idx, int total_amount, int point);

	public void setOrderProcess(String user_id, int user_idx, PayMentVO payMentVO);

	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(int user_idx);

	public ArrayList<OrderListVO> getOrderList(int user_idx);

	public ArrayList<OrderListVO> getorderListOnlyOrder(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyDeliveryOk(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyReturn(int user_idx);

	public ArrayList<OrderListVO> getOrderListSearch(int user_idx, String start, String end, String order_status_code);

	public OrderListVO getOrderListInfor(int listIdx, int orderIdx);

	public void setOrderCancelHistory(OrderCancelVO vo);

	public OrderCancelVO getorderCancelInfor(int listIdx);

	public ArrayList<OrderListVO> getOrderListOnlyChoice(int user_idx, String order_status_code);

	public ArrayList<OrderListVO> getOrderListOnlyChangeReturn(int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyRefund(int user_idx);

	public void setOrderCancelRequsetHistory(OrderCancelVO vo);

	public OrderListVO getorderListInfor2(int order_list_idx);

	public void setUsePointSub(int order_idx, int use_point);


}
