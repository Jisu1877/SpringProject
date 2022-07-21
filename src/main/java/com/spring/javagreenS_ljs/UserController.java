package com.spring.javagreenS_ljs;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.service.OrderService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.OrderCancelVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	OrderService orderService;
	
	//회원가입 비밀번호 암호화 방식 : BCryptPasswordEncoder
	@Autowired
    BCryptPasswordEncoder passwordEncoder;
	
	//로그인 창 호출
	@RequestMapping(value = "/userLogin", method = RequestMethod.GET)
	public String userLoginGet(HttpServletRequest request, Model model) {
		//쿠키에 저장된 아이디 가져오기
		Cookie[] cookies = request.getCookies();
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cUser_id")) {
				model.addAttribute("cUser_id", cookies[i].getValue());
				break;
			}
		}
		return "user/userLogin";
	}
	
	//따로 띄워주는 로그인 창 호출
	@RequestMapping(value = "/userLoginOther", method = RequestMethod.GET)
	public String userLoginOtherGet(HttpServletRequest request, Model model) {
		//쿠키에 저장된 아이디 가져오기
		Cookie[] cookies = request.getCookies();
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cUser_id")) {
				model.addAttribute("cUser_id", cookies[i].getValue());
				break;
			}
		}
		return "user/userLoginOther";
	}
	
	
	
	@RequestMapping(value = "/userJoin", method = RequestMethod.GET)
	public String userJoinGet() {
		return "user/userJoin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/userIdCheck", method = RequestMethod.POST)
	public String userIdCheckPost(String user_id) {
		UserVO vo = userService.getUserInfor(user_id);
		
		if(vo == null) {
			return "idOk";
		}
		
		return "idNo";
	}
	
	//회원가입시 이메일 인증을 위한 인증번호 발송처리
	@ResponseBody
	@RequestMapping(value = "/mailSend", method = RequestMethod.POST)
	public String mailSendPost(String email) {
		//UUID로 인증번호 만들기
		UUID uid = UUID.randomUUID();
		String sendNumber = uid.toString().substring(0,8);
		
		try {
			String toMail = email;
			String title = "[The Garden] 이메일 인증번호 안내드립니다.";
			String content = "";
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			//받는 사람, 메일제목 저장하기
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			//메일 내용 편집하여 저장하기
			content += "<img src=\"cid:theGarden.png\">";
			content += "<br><h1><b>The Garden 인증번호 : </b><font color=\"green\">&nbsp;&nbsp;";
			content += sendNumber;
			content += "</font></h1><br><h3>인증번호를 3분 이내로 입력해주시길 바랍니다. 감사합니다.</h3>";
			messageHelper.setText(content, true);
			
			// 본문의 기재된 그림파일의 경로를 따로 표시시켜준다.
			FileSystemResource file = new FileSystemResource("C:\\Users\\Hayoung\\Desktop\\JISU\\JavaGreen\\springframework\\project\\images\\theGarden.png");
			messageHelper.addInline("theGarden.png", file);
			
			//메일 전송하기
			mailSender.send(message);
			
			return sendNumber;
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	//회원가입처리
	@RequestMapping(value = "/userJoin", method = RequestMethod.POST)
	public String userJoinPost(UserVO vo, Model model) {
		//비밀번호 암호화 처리(BCryptPasswordEncoder)
		String encPwd = passwordEncoder.encode(vo.getUser_pwd());
		vo.setUser_pwd(encPwd);
		
		//회원 프로필 이미지 명 만들기(noimage_ + 성별)
		String user_image = "noimage_" + vo.getGender() + ".png";
		vo.setUser_image(user_image);
		
		userService.setUserJoin(vo);
		model.addAttribute("name", vo.getName());
		return "redirect:/msg/userJoinOk";
	}
	
	//로그인처리
	@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	public String userLoginPost(UserVO vo, Model model, HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(name ="idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name ="host_ip", defaultValue = "", required = false) String host_ip) {
		//확인을 위해 입력 아이디로 정보 가져오기
		UserVO vo2 = userService.getUserInfor(vo.getUser_id());
		
		//아이디가 일치하지 않을 경우 //비밀번호가 일치하지 않을 경우  //탈퇴한 경우
		if(vo2 == null || !passwordEncoder.matches(vo.getUser_pwd(), vo2.getUser_pwd()) || vo2.getLeave_date() != null) { 
			return "redirect:/msg/userLoginNo";
		}
		else {
			//로그인 성공 후 처리진행
			//1. 아이디 저장 체크박스 클릭 시 쿠키에 아이디 저장처리
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cUser_id", vo.getUser_id());
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else { //체크박스 해제시
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cUser_id")) {
						cookies[i].setMaxAge(0); //기존에 저장된 현재 user_id값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			//2. 필요한 정보 세션에 저장처리(레벨 한글변환/저장)
			String strLevel = "";
			if(vo2.getLevel() == 0) {
				strLevel = "관리자";
			}else if(vo2.getLevel() == 1) {
				strLevel = "Gold";
			}else if(vo2.getLevel() == 2) {
				strLevel = "Silver";
			}
			session.setAttribute("sUser_id", vo.getUser_id());
			session.setAttribute("sUser_idx", vo2.getUser_idx());
			session.setAttribute("sLevel", vo2.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			//3.최종로그인날짜, 로그인횟수 업데이트
			userService.setUserLoginUpdate(vo.getUser_id());
			
			//4.로그인 기록 테이블에 자료 저장
			userService.setUserLog(vo2.getUser_idx(), host_ip);
			
			model.addAttribute("user_id", vo.getUser_id());
			return "redirect:/msg/userLoginOk";
		}
	}
	
	//따로 띄워주는 로그인처리
	@RequestMapping(value = "/userLoginOther", method = RequestMethod.POST)
	public String userLoginOtherPost(UserVO vo, Model model, HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(name ="idCheck", defaultValue = "", required = false) String idCheck,
			@RequestParam(name ="host_ip", defaultValue = "", required = false) String host_ip) {
		//확인을 위해 입력 아이디로 정보 가져오기
		UserVO vo2 = userService.getUserInfor(vo.getUser_id());
		
		//아이디가 일치하지 않을 경우 //비밀번호가 일치하지 않을 경우  //탈퇴한 경우
		if(vo2 == null || !passwordEncoder.matches(vo.getUser_pwd(), vo2.getUser_pwd()) || vo2.getLeave_date() != null) { 
			return "redirect:/msg/userLoginNo";
		}
		else {
			//로그인 성공 후 처리진행
			//1. 아이디 저장 체크박스 클릭 시 쿠키에 아이디 저장처리
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cUser_id", vo.getUser_id());
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else { //체크박스 해제시
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cUser_id")) {
						cookies[i].setMaxAge(0); //기존에 저장된 현재 user_id값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			//2. 필요한 정보 세션에 저장처리(레벨 한글변환/저장)
			String strLevel = "";
			if(vo2.getLevel() == 0) {
				strLevel = "관리자";
			}else if(vo2.getLevel() == 1) {
				strLevel = "Gold";
			}else if(vo2.getLevel() == 2) {
				strLevel = "Silver";
			}
			session.setAttribute("sUser_id", vo.getUser_id());
			session.setAttribute("sUser_idx", vo2.getUser_idx());
			session.setAttribute("sLevel", vo2.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			//3.최종로그인날짜, 로그인횟수 업데이트
			userService.setUserLoginUpdate(vo.getUser_id());
			
			//4.로그인 기록 테이블에 자료 저장
			userService.setUserLog(vo2.getUser_idx(), host_ip);
			
			model.addAttribute("user_id", vo.getUser_id());
			return "redirect:/msg/userLoginOtherOk";
		}
	}
	
	//로그아웃 처리
	@RequestMapping(value = "/userLogout", method = RequestMethod.GET)
	public String userLogoutGet(HttpSession session, Model model) {
		
		session.invalidate();
		
		return "redirect:/user/userLogin";
	}
	
	// 로그인되어 있는지 확인
	@ResponseBody
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String loginCheckPost(HttpSession session) {
		String user_id = (String)session.getAttribute("sUser_id");
		if(user_id != null) {
			return "1";
		}
		return "0";
	}
	
	//마이페이지 창 호출
	@RequestMapping(value = "/myPageOpen", method = RequestMethod.GET)
	public String myPageOpenGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//주문 + 주문 목록 정보 가져오기(이번달 건만)
		ArrayList<OrderListVO> orderListOnlyThisMonth = orderService.getOrderListOnlyThisMonth(user_idx);
		
		//주문 + 주문 목록 정보 가져오기(결제 완료 건만)
		ArrayList<OrderListVO> orderListOnlyOrder = orderService.getorderListOnlyOrder(user_idx);
		int orderListOnlyOrderCnt = orderListOnlyOrder.size();
		
		//주문 + 주문 목록 정보 가져오기(배송중인 건만)
		ArrayList<OrderListVO> orderListOnlyDelivery = orderService.getOrderListOnlyChoice(user_idx, "4");
		int orderListOnlyDeliveryCnt = orderListOnlyDelivery.size();
		
		//주문 + 주문 목록 정보 가져오기(배송완료인 건만)
		ArrayList<OrderListVO> orderListOnlyDeliveryOk = orderService.getOrderListOnlyDeliveryOk(user_idx);
		int orderListOnlyDeliveryOkCnt = orderListOnlyDeliveryOk.size();
		
		//주문 + 주문 목록 정보 가져오기(취소/반품/교환 관련 건만)
		ArrayList<OrderListVO> orderListOnlyReturn = orderService.getOrderListOnlyReturn(user_idx);
		int orderListOnlyReturnCnt = orderListOnlyReturn.size();
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");        
        Date now = new Date();
        String nowDate = sdf1.format(now);
		
        session.setAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
        session.setAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
        session.setAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
        session.setAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
        session.setAttribute("nowDate", nowDate);
        
        model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("orderListSearch", orderListOnlyThisMonth);
		return "user/myPage";
	}
	
	
	//회원 프로필 사진 변경
	@RequestMapping(value = "/userImageChange", method = RequestMethod.POST)
	public String userImageChangePost(MultipartHttpServletRequest multipart, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		userService.setUserImageChange(multipart, user_idx);
		
		return "redirect:/msg/userImageChangeOk";
	}
	
	//관리자 프로필 사진 변경
	@RequestMapping(value = "/adminImageChange", method = RequestMethod.POST)
	public String adminImageChangePost(MultipartHttpServletRequest multipart, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		
		userService.setUserImageChange(multipart, user_idx);
		
		return "redirect:/msg/adminImageChangeOk";
	}
	
	//회원정보 수정창 호출
	@RequestMapping(value = "/userInforUpdate", method = RequestMethod.GET)
	public String userInforUpdate(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		model.addAttribute("userVO", userVO);
		return "user/userInforUpdate";
	}
	
	//회원 이름 수정
	@ResponseBody
	@RequestMapping(value = "/nameUpdate", method = RequestMethod.POST)
	public String nameUpdatePost(String name, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		userService.setUserNameUpdate(user_idx,name);
		return "1";
	}
	
	//회원 이메일 수정
	@ResponseBody
	@RequestMapping(value = "/emailUpdate", method = RequestMethod.POST)
	public String emailUpdatePost(String email, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		userService.setUserEmailUpdate(user_idx,email);
		return "1";
	}
	
	//회원 전화번호 수정
	@ResponseBody
	@RequestMapping(value = "/telUpdate", method = RequestMethod.POST)
	public String telUpdatePost(String tel, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		userService.setUserTelUpdate(user_idx,tel);
		return "1";
	}
	
	//회원 성별 수정
	@ResponseBody
	@RequestMapping(value = "/genderUpdate", method = RequestMethod.POST)
	public String genderUpdatePost(String gender, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		userService.setUserGenderUpdate(user_idx,gender);
		return "1";
	}
	
	//회원 성별 수정
	@ResponseBody
	@RequestMapping(value = "/pwdUpdate", method = RequestMethod.POST)
	public String pwdUpdatePost(String pwd, String pwdUpdate, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		String user_id = (String)session.getAttribute("sUser_id");
		
		//확인을 위해 입력 아이디로 정보 가져오기
		UserVO vo2 = userService.getUserInfor(user_id);
		
		//비밀번호가 일치하지 않을 경우
		if(!passwordEncoder.matches(pwd, vo2.getUser_pwd())) { 
			return "0";
		}
		
		//비밀번호 암호화 처리(BCryptPasswordEncoder)
		String encPwd = passwordEncoder.encode(pwdUpdate);
		
		userService.setUserPwdUpdate(user_idx,encPwd);
		return "1";
	}
	
	//회원별 결제완료 건만 조회하기
	@RequestMapping(value = "/myPageOnlyOrder", method = RequestMethod.GET)
	public String myPageOnlyOrderGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//주문 + 주문 목록 정보 가져오기(결제 완료 건만)
		ArrayList<OrderListVO> orderListOnlyOrder = orderService.getorderListOnlyOrder(user_idx);
		
		String nowDate = (String)session.getAttribute("nowDate");
		int orderListOnlyOrderCnt = (int) session.getAttribute("orderListOnlyOrderCnt");
		int orderListOnlyDeliveryCnt = (int) session.getAttribute("orderListOnlyDeliveryCnt");
		int orderListOnlyDeliveryOkCnt = (int) session.getAttribute("orderListOnlyDeliveryOkCnt");
		int orderListOnlyReturnCnt = (int) session.getAttribute("orderListOnlyReturnCnt");
		
        model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("orderListSearch", orderListOnlyOrder);
		return "user/myPage";
	}
	
	//회원별 배송중인 건만 조회하기
	@RequestMapping(value = "/myPageOnlyDelivery", method = RequestMethod.GET)
	public String myPageOnlyDeliveryGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//주문 + 주문 목록 정보 가져오기(배송중인 건만)
		ArrayList<OrderListVO> orderListOnlyDelivery = orderService.getOrderListOnlyChoice(user_idx, "4");

		String nowDate = (String)session.getAttribute("nowDate");
		int orderListOnlyOrderCnt = (int) session.getAttribute("orderListOnlyOrderCnt");
		int orderListOnlyDeliveryCnt = (int) session.getAttribute("orderListOnlyDeliveryCnt");
		int orderListOnlyDeliveryOkCnt = (int) session.getAttribute("orderListOnlyDeliveryOkCnt");
		int orderListOnlyReturnCnt = (int) session.getAttribute("orderListOnlyReturnCnt");
		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("orderListSearch", orderListOnlyDelivery);
		return "user/myPage";
	}
	
	//회원별 배송완료 건만 조회하기
	@RequestMapping(value = "/myPageOnlyDeliveryOk", method = RequestMethod.GET)
	public String myPageOnlyDeliveryOkGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//주문 + 주문 목록 정보 가져오기(배송완료인 건만)
		ArrayList<OrderListVO> orderListOnlyDeliveryOk = orderService.getOrderListOnlyDeliveryOk(user_idx);
		
		String nowDate = (String)session.getAttribute("nowDate");
		int orderListOnlyOrderCnt = (int) session.getAttribute("orderListOnlyOrderCnt");
		int orderListOnlyDeliveryCnt = (int) session.getAttribute("orderListOnlyDeliveryCnt");
		int orderListOnlyDeliveryOkCnt = (int) session.getAttribute("orderListOnlyDeliveryOkCnt");
		int orderListOnlyReturnCnt = (int) session.getAttribute("orderListOnlyReturnCnt");
		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("orderListSearch", orderListOnlyDeliveryOk);
		return "user/myPage";
	}
	
	//회원별 취소 관련 건만 조회하기
	@RequestMapping(value = "/myPageOnlyReturn", method = RequestMethod.GET)
	public String myPageOnlyReturnGet(HttpSession session, Model model) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//주문 + 주문 목록 정보 가져오기(취소/반품/교환 관련 건만)
		ArrayList<OrderListVO> orderListOnlyReturn = orderService.getOrderListOnlyReturn(user_idx);

		String nowDate = (String)session.getAttribute("nowDate");
		int orderListOnlyOrderCnt = (int) session.getAttribute("orderListOnlyOrderCnt");
		int orderListOnlyDeliveryCnt = (int) session.getAttribute("orderListOnlyDeliveryCnt");
		int orderListOnlyDeliveryOkCnt = (int) session.getAttribute("orderListOnlyDeliveryOkCnt");
		int orderListOnlyReturnCnt = (int) session.getAttribute("orderListOnlyReturnCnt");
		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("orderListSearch", orderListOnlyReturn);
		return "user/myPage";
	}
	
	
	//주문건 날짜와 조건으로 검색하기(마이페이지)
	@RequestMapping(value = "/orderSearch", method = RequestMethod.GET)
	public String orderSearchGet(HttpSession session, Model model,
			@RequestParam(name ="start", defaultValue = "", required = false) String start,
			@RequestParam(name ="end", defaultValue = "", required = false) String end,
			@RequestParam(name ="order_status_code", defaultValue = "", required = false) String order_status_code
			) {
		String user_id = (String)session.getAttribute("sUser_id");
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInfor(user_id);
		
		//전체 주문 정보 가져오기
		ArrayList<OrderListVO> orderList = orderService.getOrderList(user_idx);
		
		//주문 + 주문 목록 정보 가져오기(결제 완료 건만)
		ArrayList<OrderListVO> orderListOnlyOrder = orderService.getorderListOnlyOrder(user_idx);
		int orderListOnlyOrderCnt = orderListOnlyOrder.size();
		
		//주문 + 주문 목록 정보 가져오기(취소 건만)
		ArrayList<OrderListVO> orderListOnlyCancel = orderService.getOrderListOnlyChoice(user_idx,"3");
		
		//주문 + 주문 목록 정보 가져오기(배송중인 건만)
		ArrayList<OrderListVO> orderListOnlyDelivery = orderService.getOrderListOnlyChoice(user_idx, "4");
		int orderListOnlyDeliveryCnt = orderListOnlyDelivery.size();
		
		//주문 + 주문 목록 정보 가져오기(배송완료인 건만)
		ArrayList<OrderListVO> orderListOnlyDeliveryOk = orderService.getOrderListOnlyDeliveryOk(user_idx);
		int orderListOnlyDeliveryOkCnt = orderListOnlyDeliveryOk.size();
		
		//교환 관련 건만
		ArrayList<OrderListVO> orderListOnlyChangeReturn = orderService.getOrderListOnlyChangeReturn(user_idx);
		
		//환불 관련 건만
		ArrayList<OrderListVO> orderListOnlyRefund = orderService.getOrderListOnlyRefund(user_idx);
		
		//주문 + 주문 목록 정보 가져오기(취소/환불/교환 관련 건만)
		ArrayList<OrderListVO> orderListOnlyReturn = orderService.getOrderListOnlyReturn(user_idx);
		int orderListOnlyReturnCnt = orderListOnlyReturn.size();
		
		//조건으로 검색하기
		ArrayList<OrderListVO> orderListSearch = orderService.getOrderListSearch(user_idx, start, end, order_status_code);
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");        
		Date now = new Date();
		String nowDate = sdf1.format(now);
		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("userVO", userVO);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("code", order_status_code);
		
		if(start.equals("") && end.equals("")) {
			if(order_status_code.equals("0")) {
				model.addAttribute("orderListSearch", orderList);
			}
			else if(order_status_code.equals("1")) {
				model.addAttribute("orderListSearch", orderListOnlyOrder);
			}
			else if(order_status_code.equals("3")) {
				model.addAttribute("orderListSearch", orderListOnlyCancel);
			}
			else if(order_status_code.equals("4")) {
				model.addAttribute("orderListSearch", orderListOnlyDelivery);
			}
			else if(order_status_code.equals("5")) {
				model.addAttribute("orderListSearch", orderListOnlyDeliveryOk);
			}
			else if(order_status_code.equals("6")) {
				model.addAttribute("orderListSearch", orderListOnlyChangeReturn);
			}
			else if(order_status_code.equals("7")) {
				model.addAttribute("orderListSearch", orderListOnlyRefund);
			}
		}
		else {
			model.addAttribute("orderListSearch", orderListSearch);
		}
		return "user/myPage";
	}
}
