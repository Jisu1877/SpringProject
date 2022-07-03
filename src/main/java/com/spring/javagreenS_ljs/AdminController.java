package com.spring.javagreenS_ljs;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
	
	@ResponseBody
	@RequestMapping(value = "/category_group_useNot", method = RequestMethod.POST)
	public String category_group_useNotPost(int category_group_idx) {
		//카테고리 사용안함 처리 && 노출 레벨(99)로 조정
		adminService.setCategoryUseNot(category_group_idx);
		
		//노출 순서 조정 알고리즘
		ArrayList<CategoryGroupVO> vos = adminService.getCategoryGroupInfor();
		int cnt = 0;
		int changeLevel = 0;
		int changeValue = 0;
		for(int i=0; i<vos.size(); i++) {
			if(vos.size() == cnt + 1) {
				break;
			}
			int beforeLevel = vos.get(i).getCategory_group_level();
			if(beforeLevel != 99) {
				int nextLevel = vos.get(i+1).getCategory_group_level();
				if((beforeLevel + 1) != nextLevel) {
					changeLevel = beforeLevel + 2;
					changeValue = beforeLevel + 1;
					adminService.setCategoryLevelSort(changeLevel, changeValue);
				}
				else if(beforeLevel == changeLevel) {
					changeLevel = beforeLevel + 1;
					changeValue = beforeLevel;
					adminService.setCategoryLevelSort(changeLevel, changeValue);
				}
			}
			cnt++;
		}
		
		//노출레벨이 99개인 대분류 개수 알아오기
		int value99 = adminService.getCategoryLevel99();
		String strValue99 = String.valueOf(value99);
		
		return strValue99;
	}
}
