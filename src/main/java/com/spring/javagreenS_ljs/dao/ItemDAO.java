package com.spring.javagreenS_ljs.dao;

import org.apache.ibatis.annotations.Param;

public interface ItemDAO {

	public int getStockquantity(@Param("item_idx") int item_idx);

	public int getOptionStockquantity(@Param("option_idx") int option_idx);
	
}
