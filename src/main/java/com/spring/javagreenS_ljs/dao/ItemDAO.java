package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemDAO {

	public ItemVO getItemMaxIdx();

	public void setItemOption(@Param("maxIdx") int maxIdx, @Param("option_name") String option_name, @Param("option_price") String option_price, @Param("option_stock") String option_stock, @Param("option_sold_out") String option_sold_out);

	public void setItemImage(@Param("maxIdx") int maxIdx, @Param("sFileName") String sFileName);

	public void setItemInsert(@Param("itemVO") ItemVO itemVO);

	public void setItemImageChange(@Param("itemImage") String itemImage, @Param("maxIdx") int maxIdx);

	public void setItemNotice(@Param("maxIdx") int maxIdx, @Param("itemVO") ItemVO itemVO);

	public ArrayList<ItemVO> getItemSearch(@Param("searchString") String searchString,@Param("item_name") String item_name);

}
