package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.vo.CartVO;

@Service
public class ItemServiceImpl implements ItemService {
	
	@Autowired
	ItemDAO itemDAO;
	
	@Override
	public void setInputCart(CartVO vo) {
		String item_option_flag = vo.getItem_option_flag();
		String shipping_group_code = "";
		int user_idx = vo.getUser_idx();
		
		//옵션 사용을 안하는 상품이라면..
		if(item_option_flag.equals("n")) {
			//shipping_group_code 만들기(회원고유번호_상품고유번호_옵션사용여부_옵션고유번호)
			shipping_group_code = user_idx + "_" + vo.getItem_idx() + "_" + item_option_flag;
			vo.setShipping_group_code(shipping_group_code);
			
			//같은 shipping_group_code가 있는지 확인
			CartVO cartVO = itemDAO.getCartCodeCheck(shipping_group_code);
			
			if(cartVO == null) {
				//장바구니 DB에 저장하기
				itemDAO.setInputCart(vo);
			}
			else {
				//같은 shipping_group_code 제품 수량 + 1
				itemDAO.setQuantity(vo);
			}
		}
		//옵션 사용을 하는 상품이라면..
		else {
			for(int i=0; i<vo.getOptionIdxArr().length; i++) {
				int[] optionIdxArr = vo.getOptionIdxArr();
				String[] optionName = vo.getOptionName();
				int[] optionPrice = vo.getOptionPrice();
				int[] optionQuantity = vo.getOptionQuantity();
				shipping_group_code = user_idx + "_" + vo.getItem_idx() + "_" + item_option_flag + "_" + optionIdxArr[i];
				
				vo.setItem_option_idx(optionIdxArr[i]);
				vo.setOption_name(optionName[i]);
				vo.setOption_price(optionPrice[i]);
				vo.setOption_quantity(optionQuantity[i]);
				vo.setShipping_group_code(shipping_group_code);
				
				//같은 shipping_group_code가 있는지 확인
				CartVO cartVO = itemDAO.getCartCodeCheck(shipping_group_code);
				
				if(cartVO == null) {
					//장바구니 DB에 저장하기
					itemDAO.setInputCartWithOptions(vo);
				}
				else {
					//같은 shipping_group_code 제품 수량 + 1
					itemDAO.setQuantity2(vo);
				}
				
			}
		}
		
	}

	@Override
	public String getCartCnt(int user_idx) {
		return itemDAO.getCartCnt(user_idx);
	}

	@Override
	public ArrayList<CartVO> getCartList(int user_idx) {
		return itemDAO.getCartList(user_idx);
	}

	@Override
	public ArrayList<CartVO> getCartListGroup(int user_idx) {
		return itemDAO.getCartListGroup(user_idx);
	}

}
