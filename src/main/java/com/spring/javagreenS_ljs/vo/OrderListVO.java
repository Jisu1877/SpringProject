package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class OrderListVO {
	private int order_list_idx;
	private int order_idx;
	private int item_idx;
	private String item_name;
	private String item_image;
	private int item_price;
	private String item_option_flag;
	private String option_name;
	private String option_price;
	private String order_status_code;
	private String created_date;
}
