package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.OrderListVO;

public interface OrderDAO {

	public void setOrderListTempInsert(@Param("vo") OrderListVO vo);

	public ArrayList<OrderListVO> getOrderListTempList(@Param("user_idx") int user_idx);

	public void setOrderListTempDelete(@Param("user_idx") int user_idx);


}
