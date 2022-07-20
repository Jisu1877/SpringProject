package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;

public interface OrderDAO {

	public void setOrderListTempInsert(@Param("vo") OrderListVO vo);

	public ArrayList<OrderListVO> getOrderListTempList(@Param("user_idx") int user_idx);

	public void setOrderListTempDelete(@Param("user_idx") int user_idx);

	public void setOrder_total_amount_and_point(@Param("user_idx") int user_idx, @Param("total_amount") int total_amount, @Param("point") int point);

	public void setOrderHistory(@Param("orderVO") OrderVO orderVO);

	public int getOrderIdx(@Param("user_idx") int user_idx);

	public void setOrderListHistory(@Param("vo") OrderListVO vo);

	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(@Param("user_idx") int user_idx, @Param("firstDate") String firstDate, @Param("lastDate") String lastDate);

	public ArrayList<OrderListVO> getOrderList(@Param("user_idx") int user_idx);

	public ArrayList<OrderListVO> getorderListOnlyOrder(@Param("user_idx") int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyDeliveryOk(@Param("user_idx") int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyReturn(@Param("user_idx") int user_idx);

	public ArrayList<OrderListVO> getOrderListSearch(@Param("user_idx")int user_idx, @Param("start") String start, @Param("end") String end);

	public ArrayList<OrderListVO> getorderListOnlyOrderSearch(@Param("user_idx")int user_idx, @Param("start") String start, @Param("end") String end);

	public ArrayList<OrderListVO> getorderListOnlySearch(@Param("user_idx") int user_idx, @Param("start") String start, @Param("end") String end, @Param("code") String order_status_code);

	public ArrayList<OrderListVO> getorderListOnlyChangeOkSearch(@Param("user_idx")int user_idx, @Param("start") String start, @Param("end") String end);

	public ArrayList<OrderListVO> getorderListOnlyReturnOkSearch(@Param("user_idx")int user_idx, @Param("start") String start, @Param("end") String end);

	public OrderListVO getOrderListInfor(@Param("listIdx") int listIdx,@Param("orderIdx") int orderIdx);

	public void setOrderCancelHistory(@Param("vo") OrderCancelVO vo);

	public OrderCancelVO getorderCancelInfor(@Param("listIdx") int listIdx);

	public ArrayList<OrderListVO> getOrderListOnlyChoice(@Param("user_idx") int user_idx, @Param("order_status_code") String order_status_code);

	public ArrayList<OrderListVO> getOrderListOnlyChangeReturn(@Param("user_idx") int user_idx);

	public ArrayList<OrderListVO> getOrderListOnlyRefund(@Param("user_idx") int user_idx);

	public void setOrderCancelRequsetHistory(@Param("vo") OrderCancelVO vo);

	public int getOrderMaxIdx();

	public OrderListVO getorderListInfor2(@Param("order_list_idx") int order_list_idx);

	public void setUsePointSub(@Param("order_idx") int order_idx,@Param("use_point") int use_point);

}
