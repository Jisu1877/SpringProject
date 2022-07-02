package com.spring.javagreenS_ljs;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value = "user_id", defaultValue = "", required = false) String user_id,
			@RequestParam(value = "name", defaultValue = "", required = false) String name
			) {
		
		if(msgFlag.equals("userJoinOk")) {
			model.addAttribute("msg", name+"님 회원가입이 완료되었습니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("userLoginNo")) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("userLoginOk")) {
			model.addAttribute("msg", user_id+"님 환영합니다.");
			model.addAttribute("url", "main/mainHome");
		}
		
		return "include/message";
	}
}
