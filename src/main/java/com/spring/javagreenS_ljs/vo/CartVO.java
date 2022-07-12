package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class CartVO {
	private int cart_idx;
	private int user_idx;
	private int item_idx;
	private String user_id;
	private String item_option_flag;
	private int item_option_idx;
	private String option_name;
	private int option_price;
	private int option_quantity;
	private int total_quantity;
	private int total_price;
	private String shipping_group_code;
	private String created_date;
	
	private int[] optionIdxArr;
	private String[] optionName;
	private int[] optionPrice;
	private int[] optionQuantity;
	
}
