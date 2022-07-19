package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {
	
	@Autowired
	OrderAdminService orderAdminService;
	
	@Autowired
	UserService userService;

	@Autowired
	PagingProcess pagingProcess;
	
	@Autowired
	DeliveryService deliveryService;
	
	//주문관리 호출
    @RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String orderManagementGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "0", required = false) String part
			) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//주문내역 리스트 가져오기(페이징 처리)
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize,"adminOrder", part , "");
		ArrayList<OrderListVO> orderList = orderAdminService.getOrderList(pageVo.getStartIndexNo(), pageVo.getPageSize());
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("orderList", orderList);
		return "admin/order/orderManagement";
	} 
    
    @RequestMapping(value = "/orderInfor", method = RequestMethod.GET)
    public String orderInforGet(int idx, Model model) {
    	//주문 정보 가져오기
    	ArrayList<OrderListVO> orderList = orderAdminService.getOrderInfor(idx);
    	
    	//배송 정보 가져오기
    	int delivery_idx = orderList.get(0).getUser_delivery_idx();
    	UserDeliveryVO deliveryVO = deliveryService.getUserDeliveryInfor(delivery_idx);
    	
    	model.addAttribute("orderList", orderList);
    	model.addAttribute("deliveryVO", deliveryVO);
    	return "admin/order/orderInfor";
    }
    
    //관리자 메모 등록
    @ResponseBody
    @RequestMapping(value = "/orderMemoInput", method = RequestMethod.POST)
    public String orderMemoInputPost(int idx, String memo) {
    	orderAdminService.setOrderAdminMemo(idx,memo);
    	return "1";
    }
    
    //주문 상태 변경(idx : 주문 리스트 idx / code : 값 삽입해줄 상태코드)
    @ResponseBody
    @RequestMapping(value = "/orderCodeChange", method = RequestMethod.POST)
    public String orderCodeChangePost(int idx, String code) {
    	orderAdminService.setOrderCodeChange(idx,code);
    	return "1";
    }
    
}
