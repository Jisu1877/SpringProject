package com.spring.javagreenS_ljs.vo;

import java.util.ArrayList;

import lombok.Data;

public @Data class UserVO {
	private int user_idx;
	private String user_id;
	private String user_pwd;
	private String name;
	private String gender;
	private String email;
	private String tel;
	private String user_image;
	private int status_code;
	private int login_count;
	private int buy_count;
	private int buy_price;
	private int level;
	private int point;
	private String seller_yn;
	private int agreement;
	private String login_date;
	private String created_date;
	private String updated_date;
	private String deny_date;
	private String leave_date;
	private String leave_reason;
	
	ArrayList<OrderListVO> orderList;
}
