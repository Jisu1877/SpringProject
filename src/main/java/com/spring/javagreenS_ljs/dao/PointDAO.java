package com.spring.javagreenS_ljs.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.PointVO;

public interface PointDAO {

	public void setUsePointHistory(@Param("pointVO") PointVO pointVO);

}
