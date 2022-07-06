package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	CategoryAdminService categoryAdminService; 
	
	@RequestMapping(value ="/mainHome", method = RequestMethod.GET)
	public String mainHomeGet(Model model) {
		//카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryVOS = categoryAdminService.getCategoryOnlyUseInfor();
		model.addAttribute("categoryVOS", categoryVOS);
		return "main/home";
	}
}
