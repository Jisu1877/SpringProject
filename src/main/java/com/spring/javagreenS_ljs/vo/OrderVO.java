package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int order_idx;
	private int user_idx;
	private int order_total_amount;
	private String email;
	private String tel;
	private int user_delivery_idx;
	private String return_bank_name;
	private String return_bank_user_name;
	private String order_admin_memo;
	private String created_date;
	
	private String[] order_item_idx;
	private String[] order_item_name;
	private String[] order_item_image;
	private int[] order_item_price;
	private String[] order_item_option_flag;
	private String[] order_option_name;
	private String[] order_option_price;
	private String[] order_quantity;
	
}