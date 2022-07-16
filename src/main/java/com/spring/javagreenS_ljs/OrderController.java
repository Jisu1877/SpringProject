package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	OrderService orderService;
	
	//주문,결제 확인 창 호출
	@RequestMapping(value = "/orderCheck", method = RequestMethod.GET)
	public String orderCheckGet(OrderVO orderVO, Model model, HttpSession session) {
		
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		orderVO.setUser_idx(user_idx);
		
		//구매가능 여부 체크
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
  		String[] order_option_idx = orderVO.getOrder_option_idx();
 		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_quantity = orderVO.getOrder_quantity();
		
 		for(int i = 0; i < order_item_option_flag.length; i++) {
 			if(order_item_option_flag[i].equals("n")) {
				int item_idx = Integer.parseInt(order_item_idx[i]);
				int stock_quantity = itemService.getStockquantity(item_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", stock_quantity);
					return "redirect:/msg/quantityNO";
				}
			}
			else {
				int option_idx = Integer.parseInt(order_option_idx[i]);
				int option_stock_quantity = itemService.getOptionStockquantity(option_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > option_stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", option_stock_quantity);
					model.addAttribute("value2", order_option_name[i]);
					return "redirect:/msg/quantityOptionNO";
				}
			}
		}
		
		
		//임시 주문 목록 DB에 저장하기 전에 user_idx 로 이미 데이터가 있다면 모두 삭제처리
		//데이터가 있는지 확인
		ArrayList<OrderListVO> orderList = orderService.getOrderListTempList(user_idx);
		
		//데이터가 있다면 삭제처리
		if(orderList != null) {
			orderService.setOrderListTempDelete(user_idx);
		}
		
		//임시 주문 목록 DB에 저장
		orderService.setOrderListTempInsert(orderVO, user_idx);
		
		//등록한 배송정보 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryList(user_idx);
		String deliveryFlag = "";
		if(deliveryVO == null) {
			deliveryFlag = "n";
		}
		else {
			deliveryFlag = "y";
		}
		
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		model.addAttribute("deliveryFlag", deliveryFlag);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderVO", orderVO);
		return "order/orderPay";
	}
	
	
	//결제 진행
	@RequestMapping(value = "/orderCheck", method = RequestMethod.POST)
	public String orderCheckPost(OrderVO orderVO, Model model, HttpSession session) {
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//구매가능 여부 체크
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
  		String[] order_option_idx = orderVO.getOrder_option_idx();
 		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_quantity = orderVO.getOrder_quantity();
		
 		for(int i = 0; i < order_item_option_flag.length; i++) {
 			if(order_item_option_flag[i].equals("n")) {
				int item_idx = Integer.parseInt(order_item_idx[i]);
				int stock_quantity = itemService.getStockquantity(item_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", stock_quantity);
					return "redirect:/msg/quantityNO";
				}
			}
			else {
				int option_idx = Integer.parseInt(order_option_idx[i]);
				int option_stock_quantity = itemService.getOptionStockquantity(option_idx);
				int orderQuantity = Integer.parseInt(order_quantity[i]);
				if(orderQuantity > option_stock_quantity) {
					model.addAttribute("name", order_item_name[i]);
					model.addAttribute("value1", option_stock_quantity);
					model.addAttribute("value2", order_option_name[i]);
					return "redirect:/msg/quantityOptionNO";
				}
			}
		}
		
 		//결제로 이동하기 전 최종 결제 총 금액과 사용 포인트를 temp 데이터베이스에 저장한다.
 		int total_amount = 0;
 		int point = 0;
 		
 		if(orderVO.getOrder_total_amount_calc() != 0 && !orderVO.getPoint().equals("")) {
 			total_amount = orderVO.getOrder_total_amount_calc();
 			point = Integer.parseInt(orderVO.getPoint());
 		}
 		else {
 			total_amount = orderVO.getOrder_total_amount();
 		}
 		
 		orderService.setOrder_total_amount_and_point(user_idx, total_amount, point);
 		
 		
		//회원 정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//선택 기본 주소 가져오기
		UserDeliveryVO deliveryVO = deliveryService.getDeliveryList(user_idx);
		
		//임시 주문 테이블에서 정보를 가져오기
		ArrayList<OrderListVO> OrderTempList = orderService.getOrderListTempList(user_idx);
		
		//결제 창에 뜰 상품 이름 만들어주기
		String name = "";
		if(OrderTempList.size() > 1) {
			name = OrderTempList.get(0).getItem_name() + " 외 " + OrderTempList.size() + "건";
		}
		else {
			name = OrderTempList.get(0).getItem_name();
		}
		
		int imsi = 10;
		//결제 창으로 보내줄 정보를 set 한다.
		PayMentVO vo = new PayMentVO();
		vo.setName(name);
		vo.setAmount(imsi);
		//vo.setAmount(total_amount);
		vo.setBuyer_email(userVO.getEmail());
		vo.setBuyer_name(userVO.getName());
		vo.setBuyer_tel(userVO.getTel());
		vo.setBuyer_addr(deliveryVO.getRoadAddress());
		vo.setBuyer_postcode(deliveryVO.getPostcode());
		
		model.addAttribute("vo", vo);
		
		return "order/payment";
	}
	
	//결제 완료 후 처리
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(Model model, HttpSession session, PayMentVO payMentVO) {
		String user_id = (String) session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		//결제가 완료된 이후에 진행 처리
		orderService.setOrderProcess(user_id, user_idx);
		
		session.setAttribute("payMentVO", payMentVO);
		
		return "redirect:/msg/paymentOk";
	}
	
	@RequestMapping(value = "/payResult", method = RequestMethod.GET)
	public String payResultGet(HttpSession session, Model model) {
		
		PayMentVO payMentVO = (PayMentVO)session.getAttribute("payMentVO");
		
		model.addAttribute("payMentVO", payMentVO);
		return "order/payResult";
	}
	
}
