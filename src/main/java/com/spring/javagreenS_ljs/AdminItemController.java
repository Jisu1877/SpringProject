package com.spring.javagreenS_ljs;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

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
	
	@RequestMapping(value = "/itemInsert", method = RequestMethod.POST)
	public String itemInsertPost(ItemVO itemVO, MultipartHttpServletRequest multipart) {
		
		int maxSize = 1024 * 1024 * 20; //최대용량을 20MByte로 사용하고자 한다.
		String encoding = "UTF-8";
		
		//ga_item DB 저장
		
		
		//사진 자료 서버에 올리기(저장한 ga_item idx알아와서 DB도 저장)
		ItemImageVO itemImageVO = new ItemImageVO();
		itemAdminService.setItemImage(multipart, itemImageVO);
		
		
		return "redirect:admin/item/itemInsert";
	}
}
