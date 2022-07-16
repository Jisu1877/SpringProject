package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

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


}
