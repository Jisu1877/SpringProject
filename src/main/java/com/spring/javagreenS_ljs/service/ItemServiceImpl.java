package com.spring.javagreenS_ljs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.vo.ItemVO;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	ItemDAO itemDAO;
	
	@Override
	public int getStockquantity(int item_idx) {
		return itemDAO.getStockquantity(item_idx);
	}

	@Override
	public int getOptionStockquantity(int option_idx) {
		return itemDAO.getOptionStockquantity(option_idx);
	}

	@Override
	public void setStockQuantityUpdate(int item_idx, int order_quantity) {
		itemDAO.setStockQuantityUpdate(item_idx, order_quantity);
	}

	@Override
	public ItemVO getItemInfor(int item_idx) {
		return itemDAO.getItemInfor(item_idx);
	}
	
	

}
