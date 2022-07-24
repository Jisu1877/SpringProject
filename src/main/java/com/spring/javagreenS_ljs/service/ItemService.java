package com.spring.javagreenS_ljs.service;

import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemService {

	public int getStockquantity(int item_idx);

	public int getOptionStockquantity(int option_idx);

	public void setStockQuantityUpdate(int item_idx, int order_quantity);

	public ItemVO getItemInfor(int item_idx);


}
