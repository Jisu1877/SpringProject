package com.spring.javagreenS_ljs.dao;

import org.apache.ibatis.annotations.Param;

public interface ItemDAO {

	public int getStockquantity(@Param("item_idx") int item_idx);

	public int getOptionStockquantity(@Param("option_idx") int option_idx);

	public void setOrderUpdate(@Param("item_idx") int item_idx, @Param("quantity") int quantity);

	public void setSoldOutUpdate(@Param("item_idx") int item_idx, @Param("sold_out") String sold_out);

	public void setStockQuantityUpdate(@Param("item_idx") int item_idx, @Param("order_quantity") int order_quantity);

	public int getGivePoint(@Param("item_idx") int item_idx);
	
}
