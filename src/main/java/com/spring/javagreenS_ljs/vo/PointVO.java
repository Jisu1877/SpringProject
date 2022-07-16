package com.spring.javagreenS_ljs.vo;

import lombok.Data;

@Data
public class PointVO {
	private int save_point_idx;
	private int user_idx;
	private int save_point_amount;
	private String save_reason;
	private int order_idx;
	private String admin_id;
	private String created_date;
	
	private int use_point_idx;
	private int use_point_amount;
}
