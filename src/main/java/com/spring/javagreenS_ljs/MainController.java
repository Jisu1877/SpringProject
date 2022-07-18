package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	CategoryAdminService categoryAdminService; 
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@RequestMapping(value ="/mainHome", method = RequestMethod.GET)
	public String mainHomeGet(Model model) {
		//카테고리 가져오기
		ArrayList<CategoryGroupVO> categoryVOS = categoryAdminService.getCategoryOnlyUseInfor();
		model.addAttribute("categoryVOS", categoryVOS);
		
		//상품 가져오기
		ArrayList<ItemVO> itemVOS =  itemAdminService.getItemAllInforOnlyDisplay();
		model.addAttribute("itemVOS", itemVOS);
		
		//주간 베스트 상품 가져오기
		ArrayList<ItemVO> itemBestList = itemAdminService.getBestItemAllInforOnlyDisplay();
		model.addAttribute("itemBestList", itemBestList);
		
		return "main/home";
	}
	
	@RequestMapping(value = "/close", method = RequestMethod.GET)
	public String closeGet() {
		return "main/close";
	}
	
	//카테고리 그룹 검색
	@RequestMapping(value = "/categorySearch", method = RequestMethod.GET)
	public String categorySearchGet(@RequestParam(name="code", required = false) String code,
			@RequestParam(name="name", required = false) String name, Model model) {
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_code", code);
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		return "main/SearchResult";
	}
	
	//카테고리 검색
	@RequestMapping(value = "/categorySearch2", method = RequestMethod.GET)
	public String categorySearch2Get(@RequestParam(name="code", required = false) String code,
			@RequestParam(name="name", required = false) String name, 
			@RequestParam(name="idx", required = false) String idx, 
			@RequestParam(name="groupName", required = false) String groupName, 
			Model model) {
		String item_code = code + "_" + idx;
		String strGruopName = groupName + " >";
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_code", item_code);
		
		
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		model.addAttribute("groupName", strGruopName);
		return "main/SearchResult";
	}
	
	
}
