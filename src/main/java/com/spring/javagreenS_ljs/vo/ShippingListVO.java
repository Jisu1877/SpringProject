package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class ShippingListVO {
	private int shipping_list_idx;
	private int user_idx;
	private int order_list_idx;
	private String order_number;
	private int user_delivery_idx;
	private String shipping_company;
	private String invoice_number;
	private String created_date;
}
