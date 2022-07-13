package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

public interface DeliveryDAO {

	public UserDeliveryVO getDeliveryList(@Param("user_idx") int user_idx);

	public void setDeliveryInfor(@Param("vo") UserDeliveryVO vo);

}
