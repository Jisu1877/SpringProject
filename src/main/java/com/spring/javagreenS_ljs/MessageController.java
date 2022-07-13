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
		
		if(msgFlag.equals("NeedLogin")) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("level0OnlyOk")) {
			model.addAttribute("msg", "관리자만 접근 가능합니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("levelNo")) {
			model.addAttribute("msg", "현재 레벨에서는 접근이 불가합니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("userJoinOk")) {
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
		else if(msgFlag.equals("userLoginOtherOk")) {
			model.addAttribute("msg", user_id+"님 환영합니다.");
			model.addAttribute("url", "main/close");
		}
		else if(msgFlag.equals("userLogoutOk")) {
			model.addAttribute("msg", user_id+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("itemInsertOk")) {
			model.addAttribute("msg", "상품등록이 완료되었습니다.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("itemInquireNo")) {
			model.addAttribute("msg", "상품조회 오류. 다시 시도해주세요.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("itemUpdateNo")) {
			model.addAttribute("msg", "상품수정 오류. 다시 시도해주세요.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("itemUpdatetOk")) {
			model.addAttribute("msg", "상품수정이 완료되었습니다.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("itemDeleteNo")) {
			model.addAttribute("msg", "상품삭제 오류. 다시 시도해주세요.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("itemDeleteOk")) {
			model.addAttribute("msg", "상품삭제가 완료되었습니다.");
			model.addAttribute("url", "/admin/item/itemList");
		}
		else if(msgFlag.equals("deliveryInsertOk")) {
			model.addAttribute("msg", "배송정보 등록이 완료되었습니다.");
			model.addAttribute("url", "main/close");
		}
		
		return "include/message";
	}
}
