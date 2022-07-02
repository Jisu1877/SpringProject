package com.spring.javagreenS_ljs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/main")
public class MainController {
	
	
	@RequestMapping(value ="/mainHome", method = RequestMethod.GET)
	public String mainHomeGet() {
		return "main/home";
	}
}
