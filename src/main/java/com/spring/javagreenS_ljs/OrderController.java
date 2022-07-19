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

import com.spring.javagreenS_ljs.service.DeliveryService;
import com.spring.javagreenS_ljs.service.ItemService;
import com.spring.javagreenS_ljs.service.OrderAdminService;
import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
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
	
	@Autowired
	OrderAdminService orderAdminService;
	
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
		String[] cartIdx = orderVO.getCart_idx();
		if (cartIdx.length == 1 && "0".equals(cartIdx[0])) {
			orderService.setOrderListTempInsertForBuyNow(orderVO, user_idx);
		} else {
			orderService.setOrderListTempInsert(orderVO, user_idx);			
		}
		
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
		
		//등록한 임시 DB 가져오기
		ArrayList<OrderListVO> orderListTemp = orderService.getOrderListTempList(user_idx);
		
		model.addAttribute("deliveryFlag", deliveryFlag);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderVO", orderVO);
		model.addAttribute("orderListTemp", orderListTemp);
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
	
	
	//주문 취소 처리 창 호출
	@RequestMapping(value = "/orderCancel", method = RequestMethod.GET)
	public String orderCancelGet(@RequestParam(name="listIdx") int listIdx, Model model) {
		//취소하고자하는 주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx);
		model.addAttribute("vo", vo);
		return "order/orderCancel";
	}
	
	
	//주문 취소 처리
	@ResponseBody
	@RequestMapping(value = "/orderCancelOk", method = RequestMethod.POST)
	public String orderCancelPost(OrderCancelVO vo, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		vo.setUser_idx(user_idx);
		
		//환불 금액 알아오기
		OrderListVO listVO = orderService.getOrderListInfor(vo.getOrder_list_idx());
		vo.setReturn_price(listVO.getItem_price());
		
		//주문 취소 테이블에 저장
		orderService.setOrderCancelHistory(vo);
		
		//주문 목록 상태값 변경
		orderAdminService.setOrderCodeChange(vo.getOrder_list_idx(), "3");
		
		return "1";
	}
	
	//취소 내용 확인
	@RequestMapping(value = "/orderCancelInfor", method = RequestMethod.GET)
	public String orderCancelInforGet(@RequestParam(name="listIdx") int listIdx, Model model) {
		//취소 내용 가져오기
		OrderCancelVO vo = orderService.getorderCancelInfor(listIdx);
		
		model.addAttribute("vo", vo);
		return "order/orderCancelInfor";
	}
	
	//취소 요청 창 호출
	@RequestMapping(value = "/orderCancelRequest", method = RequestMethod.GET)
	public String orderCancelRequestGet(@RequestParam(name="listIdx") int listIdx, Model model) {
		//취소하고자하는 주문 내용 가져오기
		OrderListVO vo = orderService.getOrderListInfor(listIdx);
		model.addAttribute("vo", vo);
		return "order/orderCancelRequest";
	}
}
