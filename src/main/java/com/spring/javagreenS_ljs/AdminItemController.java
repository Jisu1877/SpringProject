package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;

@Controller
@RequestMapping("/admin/item")
public class AdminItemController {
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	CategoryAdminService categoryAdminService;
	
	@RequestMapping(value = "/itemInsert", method = RequestMethod.GET)
	public String itemInsertGet(Model model) {
		//대분류 카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryGroupVOS = categoryAdminService.getCategoryGroupInforOnlyUse();
		
		model.addAttribute("categoryVOS", categoryGroupVOS);
		return "admin/item/itemInsert";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getCategory", method = RequestMethod.POST)
	public ArrayList<CategoryVO> getCategoryPost(int category_group_idx) {
		//중분류 카테고리 가져오기
		ArrayList<CategoryVO> categoryVOS = categoryAdminService.getCategoryInfor(category_group_idx);
		return categoryVOS;
	}
}
