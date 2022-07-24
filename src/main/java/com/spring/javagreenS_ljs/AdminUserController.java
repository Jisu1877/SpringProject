package com.spring.javagreenS_ljs;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.enums.AgreeEnum;
import com.spring.javagreenS_ljs.enums.LevelEnum;
import com.spring.javagreenS_ljs.enums.SellerYnEnum;
import com.spring.javagreenS_ljs.enums.UserStatusCodeEnum;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.UserAdminService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	
	@Autowired
	UserAdminService userAdminService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userListGet(UserVO searchVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		// 페이징
		int totCnt = userAdminService.getUserListTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("userList", userAdminService.getUserList(searchVO));
		return "admin/user/userList";
	}
	
	@RequestMapping(value = "/userInforUpdate", method = RequestMethod.GET)
	public String userInforUpdateGet(UserVO searchVO, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		UserVO user = userService.getUserInfor(searchVO.getUser_id());
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("user", user);
		model.addAttribute("statusList", UserStatusCodeEnum.values());
		model.addAttribute("levelList", LevelEnum.values());
		model.addAttribute("sellerYnList", SellerYnEnum.values());
		model.addAttribute("agreeList", AgreeEnum.values());
		
		return "admin/user/userInforUpdate";
	}
}
