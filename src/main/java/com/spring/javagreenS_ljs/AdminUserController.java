package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.UserAdminService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.UserStatusCodeEnum;
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
	public String userListGet(UserVO searchVO, Model model, HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
//		//페이징처리
		int totCnt = userAdminService.getUserListTotalCnt(searchVO);
//		PageVO pageVO = pagingProcess.pageProcess3(searchVO, totCnt);
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("userList", userAdminService.getUserList(searchVO));
//		model.addAttribute("pageVo", pageVO);
		return "admin/user/userList";
	}
}
