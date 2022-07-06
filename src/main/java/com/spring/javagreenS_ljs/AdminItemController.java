package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
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
	
	//상품등록 처리
	@RequestMapping(value = "/itemInsert", method = RequestMethod.POST)
	public String itemInsertPost(ItemVO itemVO, MultipartHttpServletRequest multipart, HttpSession session) {
		//관리자 ID 저장
		String adminID = (String)session.getAttribute("sUser_id");
		itemVO.setCreated_admin_id(adminID);
		
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/itemContent/ 폴더에 저장시켜준다.
		itemAdminService.imgCheck(itemVO.getDetail_content());
		
		//상품등록 처리를 위한 작업들
		itemAdminService.setItemInsert(itemVO, multipart);
		
		
		return "redirect:/msg/itemInsertOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getItemInforCopy", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getItemInforCopy(String item_name) {
		ArrayList<ItemVO> vos = itemAdminService.getItemSearch("item_name" , item_name);
		Gson gson = new Gson();
		String vosJson = gson.toJson(vos);
		return vosJson;
	}
}
