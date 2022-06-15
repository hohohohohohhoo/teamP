package kr.co.dw.controller.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dw.domain.MemberDTO;
import kr.co.dw.service.member.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService mService; // autowired를 갖고있어서 
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout() {
		
		
		
		return  "redirect:/board/list";
	}
	
	@RequestMapping(value = "/loginget", method = RequestMethod.GET)
	public String login(){

		return "/member/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberDTO mDto, Model model){
		
		MemberDTO login = mService.login(mDto);
		
		model.addAttribute("login", login);
		
		

		return "redirect:/board/list";
	}
	

   
}