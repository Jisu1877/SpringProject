package com.spring.javagreenS_ljs;

import java.net.http.HttpResponse;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	JavaMailSender mailSender;
	
	//회원가입 비밀번호 암호화 방식 : BCryptPasswordEncoder
	@Autowired
    BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/userLogin", method = RequestMethod.GET)
	public String userLoginGet() {
		return "user/userLogin";
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
			String title = "[The Garden] 회원가입을 위한 Email 인증번호";
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
		
		userService.setUserJoin(vo);
		model.addAttribute("name", vo.getName());
		return "redirect:/msg/userJoinOk";
	}
	
	//로그인처리
	@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	public String userLoginPost(UserVO vo, Model model, HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(name ="idCheck", defaultValue = "", required = false) String idCheck) {
		//확인을 위해 입력 아이디로 정보 가져오기
		UserVO vo2 = userService.getUserInfor(vo.getUser_id());
		
		//아이디가 일치하지 않을 경우
		if(vo2 == null) { 
			return "redirect:/msg/userLoginNo";
		} 
		//비밀번호가 일치하지 않을 경우
		else if(!passwordEncoder.matches(vo.getUser_pwd(), vo2.getUser_pwd())) {
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
			session.setAttribute("sLevel", vo2.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			//3.최종로그인날짜, 로그인횟수 업데이트
			userService.setUserLoginUpdate(vo.getUser_id());
			
			//4.로그인 기록 테이블에 자료 저장
			
			model.addAttribute("user_id", vo.getUser_id());
			return "redirect:/msg/userLoginOk";
		}
	}
}
