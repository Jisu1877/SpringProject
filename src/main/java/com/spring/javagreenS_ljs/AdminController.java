package com.spring.javagreenS_ljs;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	UserService userService;
	
	//관리자 홈 호출
	@RequestMapping(value = "/mainHome", method = RequestMethod.GET)
	public String mainHomeGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		return "admin/mainHome";
	}
	
	//오프라인 매장 등록 창 호출
	@RequestMapping(value = "/offlineStoreInsert", method = RequestMethod.GET)
	public String offlineStoreInsertGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		return "admin/other/offlineStoreInsert";
	}
}
