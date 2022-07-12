package com.spring.javagreenS_ljs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	//관리자 홈 호출
	@RequestMapping(value = "/mainHome", method = RequestMethod.GET)
	public String mainHomeGet() {
		return "admin/mainHome";
	}
	
	//오프라인 매장 등록 창 호출
	@RequestMapping(value = "/offlineStoreInsert", method = RequestMethod.GET)
	public String offlineStoreInsertGet() {
		return "admin/other/offlineStoreInsert";
	}
}
