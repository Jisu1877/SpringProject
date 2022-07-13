package com.spring.javagreenS_ljs;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	
	@Autowired
	DeliveryService deliveryService;
	
	@RequestMapping(value = "/deliveryInsert", method = RequestMethod.GET)
	public String deliveryInsertGet(String flag, Model model) {
		
		model.addAttribute("flag", flag);
		return "delivery/deliveryInsert";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deliveryInsert", method = RequestMethod.POST)
	public String deliveryInsertPost(UserDeliveryVO vo, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		deliveryService.setDeliveryInfor(vo);
		
		return "1";
	}
}
