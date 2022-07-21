package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
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
	
	@Autowired
	OrderController orderController;
	
	@Autowired
	OrderService orderService; 
	
	@Autowired
	ItemService itemService;
	
	//주문관리 호출
    @RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String orderManagementGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "0", required = false) String part,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchValue", defaultValue = "", required = false) String searchValue,
			@RequestParam(name="start", defaultValue = "", required = false) String start,
			@RequestParam(name="end", defaultValue = "", required = false) String end
			) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//주문내역 리스트 가져오기(페이징 처리)
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize,"adminOrder", part , search, searchValue, start, end);
		
		ArrayList<String> partArray = new ArrayList<String>();
		partArray.add(part);
		
		ArrayList<OrderListVO> orderList = orderAdminService.getOrderList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part, search, searchValue, start, end);
		
		model.addAttribute("code", part);
		model.addAttribute("search", search);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
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
    
    //취소 요청 처리 창 호출
    @RequestMapping(value = "/orderCancelRequest", method = RequestMethod.GET)
    public String orderCancelRequestGet(
    		@RequestParam(name="listIdx") int listIdx,
			@RequestParam(name="orderIdx") int orderIdx, HttpSession session, Model model) {
    	
    	//취소 요청 정보 가져오기
    	OrderCancelVO cancelVO = orderAdminService.getOrderCancelRequestInfor(listIdx,orderIdx);
    	
    	System.out.println("cancelVO : " + cancelVO);
    	//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(cancelVO.getUser_idx());
		
		model.addAttribute("userVO", userVO);
    	model.addAttribute("vo", cancelVO);
    	return "admin/order/orderCancelRequestAdmin";
    }
    
    
    //취소 요청 처리
    @Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
    @ResponseBody
    @RequestMapping(value = "/orderCancelProcess", method = RequestMethod.POST)
    public String orderCancelProcessPost(OrderCancelVO vo) {
    	//관리자 메세지 등록 및 승인 여부 등록
    	orderAdminService.setOrderCancelRequestAnswer(vo);
    	
    	//취소 승인 시..
    	if(vo.getRequest_answer().equals("y")) {
    		//취소 요청 정보 가져와서 취소 처리 서비스로 보내기
    		OrderCancelVO requestVO = orderAdminService.getOrderCancelRequestInfor(vo.getOrder_list_idx(), vo.getOrder_idx());
    		
    		//취소 처리
    		//주문 취소 테이블에 저장
    		orderService.setOrderCancelHistory(requestVO);
    		
    		//주문 목록 상태값 변경
    		orderAdminService.setOrderCodeChange(requestVO.getOrder_list_idx(), "3");
    		
    		//주문 목록 정보 가져오기
    		OrderListVO orderListVO = orderService.getorderListInfor2(requestVO.getOrder_list_idx());
    		
    		//상품 재고 수량 재 업데이트
    		int item_idx = orderListVO.getItem_idx();
    		int order_quantity = orderListVO.getOrder_quantity();
    		itemService.setStockQuantityUpdate(item_idx, order_quantity);
    		
    	}
    	else {
    		//취소 반려 시..
    		//주문 목록 상태값 변경
    		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "16");
    		
    		//주문 테이블의 사용 포인트 차감 돌려놓기
    		if(vo.getUse_point() != 0) {
    			orderService.setUsePointPlus(vo.getOrder_idx(), vo.getUse_point());
    		}
    	}
    	return "1";
    }
    
    //배송관리 호출
    @RequestMapping(value = "/orderDelivery", method = RequestMethod.GET)
	public String orderDeliveryGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "0", required = false) String part,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchValue", defaultValue = "", required = false) String searchValue,
			@RequestParam(name="start", defaultValue = "", required = false) String start,
			@RequestParam(name="end", defaultValue = "", required = false) String end
			) {
    	String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		model.addAttribute("userVO", userVO);
		
		//주문 관리만
		part = "2";
		
		//주문내역 리스트 가져오기(페이징 처리)
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize,"orderDelivery", part, search, searchValue, start, end);
		ArrayList<OrderListVO> orderList = orderAdminService.getOrderList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part, search, searchValue, start, end);
		
		model.addAttribute("code", part);
		model.addAttribute("search", search);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("orderList", orderList);
		return "admin/order/orderDelivery";
	} 
    
}
