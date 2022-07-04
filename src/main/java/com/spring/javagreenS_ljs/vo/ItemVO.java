package com.spring.javagreenS_ljs.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ItemVO {
	private int item_idx;
	private String item_code;
	private String item_name;
	private String item_summary;
	private String display_flag;
	private int sale_price;
	private String seller_discount_flag;
	private int seller_discount_amount;
	private String seller_point_flag;
	private int seller_point;
	private String sold_out;
	private int stock_quantity;
	private String stock_schedule_date;
	private int order_min_quantity;
	private int order_max_quantity;
	private int sale_quantity;
	private String item_option_flag;
	private String detail_content_flag;
	private String detail_content;
	private String detail_content_image;
	private String brand;
	private String form;
	private String item_model_name;
	private String origin_country;
	private String after_service;
	private int item_notice_idx;
	private String item_image;
	private String shipment_address;
	private String shipment_return_address;
	private String shipment_type;
	private int shipping_price;
	private int shipping_free_amount;
	private int shipping_extra_charge;
	private String item_return_flag;
	private int shipping_return_price;
	private String item_keyword;
	private String created_admin_id;
	private String created_date;
	
	private ItemOptionVO itemOptionVO;
	private ItemImageVO itemImageVO;
	private ArrayList<ItemImageVO> itemImageList;
	private ItemNoticeVO itemNoticeVO;
}
