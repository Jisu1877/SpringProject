package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface OrderAdminDAO {

	public int totRecCnt();

	public ArrayList<OrderListVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<OrderListVO> getOrderInfor(@Param("idx") int idx);

	public void setOrderAdminMemo(@Param("idx")int idx,@Param("memo") String memo);

	public void setOrderCodeChange(@Param("idx")int idx,@Param("code") String code);

}
