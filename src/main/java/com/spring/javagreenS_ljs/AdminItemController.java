package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
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
	
	@RequestMapping(value = "/itemList", method = RequestMethod.GET)
	public String itemListGet(Model model) {
		ArrayList<ItemVO> vos = itemAdminService.getItemList();
		model.addAttribute("vos", vos);
		return "admin/item/itemList";
	}
	
	//상품 조회 창 호출
	@RequestMapping(value = "/itemInquire", method = RequestMethod.GET)
	public String itemInquireGet(Model model, @RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code) {
		if(item_code.equals("NO")) {
			return "redirect:/msg/itemInquireNo";
		}
		//상품정보 + 상품정보고시 정보 가져오기
		ItemVO itemVO = itemAdminService.getItemSameSearch("item_code", item_code);
		
		//상품카테고리 코드 분리
		String[] code = item_code.split("_");
		int category_idx = Integer.parseInt(code[1]);
		
		//카테고리 검색(카테고리 명을 알아오기 위함)
		CategoryGroupVO categoryGroupVO = categoryAdminService.getCategoryGroupInfor(code[0]);
		itemVO.setCategory_group_name(categoryGroupVO.getCategory_group_name());
		//중분류가 존재하면..
		if(category_idx != 0) {
			CategoryVO categoryVO = categoryAdminService.getCategoryInfor2(category_idx);	
			itemVO.setCategory_name(categoryVO.getCategory_name());
		}
		else {
			itemVO.setCategory_name("NO");
		}
		
		//옵션정보 가져와서 Set
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
		itemVO.setItemImageList(imageList);
		
		model.addAttribute("itemVO" ,itemVO);
		return "admin/item/itemInquire";
	}
	
	//상품 수정 창 호출
	@RequestMapping(value = "/itemUpdate", method = RequestMethod.GET)
	public String itemUpdateGet(Model model, @RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code) {
		if(item_code.equals("NO")) {
			return "redirect:/msg/itemUpdateNo";
		}
		//상품정보 + 상품정보고시 정보 가져오기
		ItemVO itemVO = itemAdminService.getItemSameSearch("item_code", item_code);
		
		//상품카테고리 코드 분리
		String[] code = item_code.split("_");
		int category_idx = Integer.parseInt(code[1]);
		
		//카테고리 검색(카테고리 명을 알아오기 위함)
		CategoryGroupVO categoryGroupVO = categoryAdminService.getCategoryGroupInfor(code[0]);
		itemVO.setCategory_group_name(categoryGroupVO.getCategory_group_name());
		//중분류가 존재하면..
		if(category_idx != 0) {
			CategoryVO categoryVO = categoryAdminService.getCategoryInfor2(category_idx);	
			itemVO.setCategory_name(categoryVO.getCategory_name());
		}
		else {
			itemVO.setCategory_name("NO");
		}
		
		//옵션정보 가져와서 Set
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
		itemVO.setItemImageList(imageList);
		
		model.addAttribute("itemVO" ,itemVO);
		return "admin/item/itemUpdate";
	}
}
