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

import com.spring.javagreenS_ljs.service.CategoryAdminService;
import com.spring.javagreenS_ljs.service.ItemAdminService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.vo.CartVO;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

@Controller
@RequestMapping("/item")
public class ItemController {
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	ItemAdminService itemAdminService;
	
	@Autowired
	CategoryAdminService categoryAdminService;
	
	@RequestMapping(value = "/itemView", method = RequestMethod.GET)
	public String itemViewGet(Model model, @RequestParam(name="item_code", defaultValue = "NO", required = false) String item_code) {
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
		
		//카테고리 대분류 모든 정보 가져오기
		ArrayList<CategoryGroupVO> categoryGroupList = categoryAdminService.getCategoryGroupInforOnlyUse();
		itemVO.setCategoryGroupList(categoryGroupList);
		
		//옵션정보 가져와서 Set
		ArrayList<ItemOptionVO> optionList = itemAdminService.getItemOptionInfor(itemVO.getItem_idx());
		itemVO.setItemOptionList(optionList);
		
		//이미지정보 가져와서 Set
		ArrayList<ItemImageVO> imageList = itemAdminService.getItemImageInfor(itemVO.getItem_idx());
		itemVO.setItemImageList(imageList);
		
		model.addAttribute("itemVO" ,itemVO);
		return "item/itemView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String loginCheckPost(HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		if(user_id != null) {
			return "1";
		}
		return "0";
	}
	
	
	//장바구니 담기
	@ResponseBody
	@RequestMapping(value = "/inputCart", method = RequestMethod.POST)
	public String inputCartPost(CartVO vo, HttpSession session) {
		//세션 값 저장
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int)session.getAttribute("sUser_idx");
		vo.setUser_id(user_id);
		vo.setUser_idx(user_idx);
		
		itemService.setInputCart(vo);
		
		return "1";
	}
	
	//장바구니 리스트로 이동
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public String cartListGet(HttpSession session, Model model) {
		int user_idx = (int)session.getAttribute("sUser_idx");
		
		//장바구니 목록 가져오기
		ArrayList<CartVO> cartVOS = itemService.getCartList(user_idx);
		
		ArrayList<ItemVO> itemVOS = new ArrayList<ItemVO>();
		//상품 정보 가져오기
		for(int i=0; i<cartVOS.size(); i++) {
			ItemVO itemVO = itemAdminService.getItemContent(cartVOS.get(i).getItem_idx());
			itemVOS.add(itemVO);
		}
		
		model.addAttribute("itemVOS", itemVOS);
		model.addAttribute("cartVOS", cartVOS);
		return "order/cartListTable";
	}
	
	//해당 회원 장바구니 담긴 개수 알아오기
	@ResponseBody
	@RequestMapping(value = "/cartCheck", method = RequestMethod.POST)
	public String cartCheckPost(HttpSession session) {
		String  cnt = "";
		if(session.getAttribute("sUser_idx") != null) {
			int user_idx = (int)session.getAttribute("sUser_idx");
			cnt = itemService.getCartCnt(user_idx);
		}
		return cnt;
	}
	
}
