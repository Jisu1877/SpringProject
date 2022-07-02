package com.spring.javagreenS_ljs;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.AdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	//관리자 홈 호출
	@RequestMapping(value = "/mainHome", method = RequestMethod.GET)
	public String mainHomeGet() {
		return "admin/mainHome";
	}	
	
	//카테고리 화면 호출
	@RequestMapping(value = "/categoryHome", method = RequestMethod.GET)
	public String categoryHomeGet(Model model) {
		ArrayList<CategoryGroupVO> vos = adminService.getCategoryGroupInfor();
		model.addAttribute("vos", vos);
		return "admin/categoryHome";
	}
	
	@ResponseBody
	@RequestMapping(value = "/category_group_input", method = RequestMethod.POST)
	public String category_group_inputPost(String category_group_name, int category_group_level) {
		//카테고리 그룹 코드 만들기(UUID)
		UUID uid = UUID.randomUUID();
		String category_group_code = uid.toString().substring(0,8);
	
		//만든 코드가 겹치는 지 확인
		CategoryGroupVO vo = adminService.getCategoryGroupInfor(category_group_code);
		
		//겹치지 않을 때까지 새로운 코드를 만들기
		if(vo != null) {
			while(true) {
				UUID uid2 = UUID.randomUUID();
				category_group_code = uid.toString().substring(0,8);
				CategoryGroupVO vo2 = adminService.getCategoryGroupInfor(category_group_code);
				if(vo2 == null) {
					break;
				}
			}
		}
		vo = new CategoryGroupVO();
		vo.setCategory_group_code(category_group_code);
		vo.setCategory_group_name(category_group_name);
		vo.setCategory_group_level(category_group_level);
		//카테고리 등록처리
		adminService.setCategoryGroup(vo);
		return "1";
	}

}
