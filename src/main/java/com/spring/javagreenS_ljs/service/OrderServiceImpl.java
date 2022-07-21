package com.spring.javagreenS_ljs.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javagreenS_ljs.dao.CartDAO;
import com.spring.javagreenS_ljs.dao.DeliveryDAO;
import com.spring.javagreenS_ljs.dao.ItemDAO;
import com.spring.javagreenS_ljs.dao.OrderDAO;
import com.spring.javagreenS_ljs.dao.PointDAO;
import com.spring.javagreenS_ljs.dao.UserDAO;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.OrderVO;
import com.spring.javagreenS_ljs.vo.PayMentVO;
import com.spring.javagreenS_ljs.vo.PointVO;
import com.spring.javagreenS_ljs.vo.UserDeliveryVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	DeliveryDAO diDeliveryDAO;
	
	@Autowired
	CartDAO cartDAO;
	
	@Autowired
	PointDAO pointDAO;
	
	@Autowired
	ItemDAO itemDAO;
	
	@Override
	public void setOrderListTempInsert(OrderVO orderVO, int user_idx) { 
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_image = orderVO.getOrder_item_image();
		int[] order_item_price = orderVO.getOrder_item_price();
		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
		String[] order_option_idx = orderVO.getOrder_option_idx();
		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_option_price = orderVO.getOrder_option_price();
		String[] order_quantity = orderVO.getOrder_quantity();
		String[] strCart_idx = orderVO.getCart_idx();
		
		for(int i = 0; i < order_item_idx.length; i++) { //여기가 문제다 문제 ㅠㅠ 바로구매하면 옵션2개를 선택해도 1개만 들어간당..
			OrderListVO vo = new OrderListVO();
			
			vo.setUser_idx(user_idx);
			
			int item_idx = Integer.parseInt(order_item_idx[i]);
			int cart_idx = Integer.parseInt(strCart_idx[i]);
			int option_idx = 0;
			
			if(order_option_idx.length > 0) {
				if(!order_option_idx[i].equals("")) {
					option_idx = Integer.parseInt(order_option_idx[i]);
				}
			}
			
			int quantity = Integer.parseInt(order_quantity[i]);
			vo.setItem_idx(item_idx);
			vo.setItem_name(order_item_name[i]);
			vo.setItem_image(order_item_image[i]);
			vo.setItem_price(order_item_price[i]);
			vo.setItem_option_flag(order_item_option_flag[i]);
			vo.setOption_idx(option_idx);
			vo.setOption_name(order_option_name[i]);
			vo.setOption_price(order_option_price[i]);
			vo.setOrder_quantity(quantity);
			vo.setCart_idx(cart_idx);
			
			orderDAO.setOrderListTempInsert(vo);
		}
	}
	
	@Override
	public void setOrderListTempInsertForBuyNow(OrderVO orderVO, int user_idx) {
		String[] order_item_idx = orderVO.getOrder_item_idx();
		String[] order_item_name = orderVO.getOrder_item_name();
 		String[] order_item_image = orderVO.getOrder_item_image();
		int[] order_item_price = orderVO.getOrder_item_price();
		String[] order_item_option_flag = orderVO.getOrder_item_option_flag();
		String[] order_option_idx = orderVO.getOrder_option_idx();
		String[] order_option_name = orderVO.getOrder_option_name();
		String[] order_option_price = orderVO.getOrder_option_price();
		String[] order_quantity = orderVO.getOrder_quantity();
		String[] strCart_idx = orderVO.getCart_idx();
		
		for(int i = 0; i < order_item_idx.length; i++) { //여기가 문제다 문제 ㅠㅠ 바로구매하면 옵션2개를 선택해도 1개만 들어간당..
			OrderListVO vo = new OrderListVO();
			
			vo.setUser_idx(user_idx);
			
			int item_idx = Integer.parseInt(order_item_idx[i]);
			int cart_idx = Integer.parseInt(strCart_idx[i]);
			int option_idx = 0;
			
			if(order_option_idx.length > 0) {
				if(!order_option_idx[i].equals("")) {
					option_idx = Integer.parseInt(order_option_idx[i]);
				}
			}
			
			int quantity = Integer.parseInt(order_quantity[i]);
			vo.setItem_idx(item_idx);
			vo.setItem_name(order_item_name[i]);
			vo.setItem_image(order_item_image[i]);
			vo.setItem_option_flag(order_item_option_flag[i]);
			vo.setOption_idx(option_idx);
			vo.setOption_name(order_option_name[i]);
			vo.setOption_price(order_option_price[i]);
			vo.setOrder_quantity(quantity);
			vo.setCart_idx(cart_idx);
			
			if(order_option_idx.length == 1)  {
				vo.setItem_price(order_item_price[0]);
			}
			else {
				vo.setItem_price(order_item_price[0]);
			}
			
			orderDAO.setOrderListTempInsert(vo);
		}
	}

	@Override
	public void setOrderListTempDelete(int user_idx) {
		orderDAO.setOrderListTempDelete(user_idx);
	}

	@Override
	public void setOrder_total_amount_and_point(int user_idx, int total_amount, int point) {
		orderDAO.setOrder_total_amount_and_point(user_idx, total_amount, point);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListTempList(int user_idx) {
		return orderDAO.getOrderListTempList(user_idx);
	}
	
	
	@Transactional(rollbackFor = Exception.class) //트랜잭션 처리 
	@Override
	public void setOrderProcess(String user_id, int user_idx, PayMentVO payMentVO) {
		//임시 주문 목록 정보 가져오기
		ArrayList<OrderListVO> orderListTemp = orderDAO.getOrderListTempList(user_idx);
		
		//회원 정보 가져오기
		UserVO userVO = userDAO.getUserInfor(user_id);
		
		//회원 선택 배송지 정보 가져오기
		UserDeliveryVO deliveryVO = diDeliveryDAO.getDeliveryList(user_idx);
		
		// 필요한 정보 vo set
		OrderVO orderVO = new OrderVO();
		
		int total_amount = orderListTemp.get(0).getOrder_total_amount();
		
		orderVO.setUser_idx(user_idx);
		orderVO.setOrder_total_amount(total_amount);
		orderVO.setEmail(userVO.getEmail());
		orderVO.setTel(userVO.getTel());
		orderVO.setUser_delivery_idx(deliveryVO.getUser_delivery_idx());
		
		//사용 포인트
		int point = orderListTemp.get(0).getUse_point();
		orderVO.setUse_point(point);
		
		//주문번호 만들기
		String applyNum = payMentVO.getApply_num();
		//주문 테이블 최대 idx 알아오기
		int orderMaxIdx = (orderDAO.getOrderMaxIdx() + 1);
		String order_number = applyNum + "_" + orderMaxIdx;
		orderVO.setOrder_number(order_number);
		
		// 주문 테이블 저장
		orderDAO.setOrderHistory(orderVO);
		
		//방금 저장한 order_idx 알아오기
		int order_idx  = orderDAO.getOrderIdx(user_idx);
		
		for(int i = 0; i < orderListTemp.size(); i++) {
			//주문 목록 테이블 저장
			OrderListVO vo = orderListTemp.get(i);
			vo.setOrder_idx(order_idx);
			orderDAO.setOrderListHistory(vo);
			
			//장바구니 삭제(주문한 물품만)
			if(vo.getCart_idx() != 0) {
				cartDAO.setCartDelete(vo.getCart_idx());
			}
			
			//상품 정보 수정(상품 재고 수량 차감 / 판매수량 증가 처리)
			int item_idx = orderListTemp.get(i).getItem_idx();
			int quantity = orderListTemp.get(i).getOrder_quantity();
			itemDAO.setOrderUpdate(item_idx,quantity);
			
			//상품 품절 여부 체크
			int stock_quantity = itemDAO.getStockquantity(item_idx);
			String sold_out = "0";
			
			if(stock_quantity == 0) {
				sold_out = "1";
			}
			else if(stock_quantity > 0){
				sold_out = "0";
			}
			else { //만약 음수값이 들어온다면..
				sold_out = "1";
			}
			
			//품절 여부 업데이트
			itemDAO.setSoldOutUpdate(item_idx,sold_out);
			
		}
		
		//포인트 사용 시 포인트 사용 내용 저장
		if(point != 0) {
			PointVO pointVO = new PointVO();
			pointVO.setUser_idx(user_idx);
			pointVO.setUse_point_amount(point);
			pointVO.setOrder_idx(order_idx);
			pointDAO.setUsePointHistory(pointVO);
			
			//회원 포인트 차감
			userDAO.setPointUseUpate(user_idx, point);
		}
		
		//회원 정보 수정(구매 횟수 추가 / 구매 총가격 누적 업데이트)
		//userDAO.setOrderUpdate(user_idx,total_amount); //구매확정 시 추가해주는 것으로 변경
		
		//임시 DB 삭제
		orderDAO.setOrderListTempDelete(user_idx);
		
	}
	
	//마이페이지에서 호출/회원별 주문 목록 조회(이번 달 주문 건만)
	@Override
	public ArrayList<OrderListVO> getOrderListOnlyThisMonth(int user_idx) {
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");        
        Date now = new Date();
        String nowDate = sdf1.format(now);
		
        LocalDate date = LocalDate.parse(nowDate);
        
        //이번달의 첫날
        LocalDate firstDate = date.withDayOfMonth(1);
        //이번달의 마지막날
        LocalDate lastDate = date.withDayOfMonth(date.lengthOfMonth());
		
		return orderDAO.getOrderListOnlyThisMonth(user_idx, firstDate.toString(), lastDate.toString());
	}

	@Override
	public ArrayList<OrderListVO> getOrderList(int user_idx) {
		return orderDAO.getOrderList(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getorderListOnlyOrder(int user_idx) {
		return orderDAO.getorderListOnlyOrder(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyDeliveryOk(int user_idx) {
		return orderDAO.getOrderListOnlyDeliveryOk(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyReturn(int user_idx) {
		return orderDAO.getOrderListOnlyReturn(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListSearch(int user_idx, String start, String end, String order_status_code) {
		//상태 코드에 따라 return 이 달라진다.
		//전체조회
		if(order_status_code.equals("0")) {
			return orderDAO.getOrderListSearch(user_idx, start, end);
		}
		//결제완료
		else if(order_status_code.equals("1")) {
			return orderDAO.getorderListOnlyOrderSearch(user_idx, start, end);
		}
		//취소 or 배송중 or 배송완료
		else if(order_status_code.equals("3") || order_status_code.equals("4") || order_status_code.equals("5")) {
			return orderDAO.getorderListOnlySearch(user_idx, start, end, order_status_code);
		}
		//교환 관련 건
		else if(order_status_code.equals("6")) {
			return orderDAO.getorderListOnlyChangeOkSearch(user_idx, start, end);
		}
		else {
			return orderDAO.getorderListOnlyReturnOkSearch(user_idx, start, end);
		}
	}

	@Override
	public OrderListVO getOrderListInfor(int listIdx, int orderIdx) {
		return orderDAO.getOrderListInfor(listIdx, orderIdx);
	}

	@Override
	public void setOrderCancelHistory(OrderCancelVO vo) {
		orderDAO.setOrderCancelHistory(vo);
	}

	@Override
	public OrderCancelVO getorderCancelInfor(int listIdx) {
		return orderDAO.getorderCancelInfor(listIdx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyChoice(int user_idx, String order_status_code) {
		return orderDAO.getOrderListOnlyChoice(user_idx, order_status_code);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyChangeReturn(int user_idx) {
		return orderDAO.getOrderListOnlyChangeReturn(user_idx);
	}

	@Override
	public ArrayList<OrderListVO> getOrderListOnlyRefund(int user_idx) {
		return orderDAO.getOrderListOnlyRefund(user_idx);
	}

	@Override
	public void setOrderCancelRequsetHistory(OrderCancelVO vo) {
		orderDAO.setOrderCancelRequsetHistory(vo);
	}

	@Override
	public OrderListVO getorderListInfor2(int order_list_idx) {
		return orderDAO.getorderListInfor2(order_list_idx);
	}

	@Override
	public void setUsePointSub(int order_idx, int use_point) {
		orderDAO.setUsePointSub(order_idx, use_point);
	}

	@Override
	public void setUsePointPlus(int order_idx, int use_point) {
		orderDAO.setUsePointPlus(order_idx,use_point);
	}

}
