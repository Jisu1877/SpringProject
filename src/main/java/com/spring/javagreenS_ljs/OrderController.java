package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/orderCheck", method = RequestMethod.GET)
	public String orderCheckGet(OrderVO orderVO, Model model, HttpSession session) {
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		orderVO.setUser_idx(user_idx);
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryList(user_idx);
		String deliveryFlag = "";
		if(deliveryVO == null) {
			deliveryFlag = "n";
		}
		else {
			deliveryFlag = "y";
		}
		
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		model.addAttribute("deliveryFlag", deliveryFlag);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderVO", orderVO);
		return "order/orderPay";
	}
	
	
	@RequestMapping(value = "/orderCheck", method = RequestMethod.POST)
	public String orderCheckPost(OrderVO orderVO, Model model, HttpSession session) {
		System.out.println("orderVO : " + orderVO);
		
		return "1";
	}
}
