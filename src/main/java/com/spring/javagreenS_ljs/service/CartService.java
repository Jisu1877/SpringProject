package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.CartVO;

public interface CartService {

	public void setInputCart(CartVO vo);

	public String getCartCnt(int user_idx);

	public ArrayList<CartVO> getCartList(int user_idx);

	public ArrayList<CartVO> getCartListGroup(int user_idx);
	
}
