package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.OrderListVO;

public interface OrderAdminDAO {

	public int totRecCnt();

	public ArrayList<OrderListVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

}
