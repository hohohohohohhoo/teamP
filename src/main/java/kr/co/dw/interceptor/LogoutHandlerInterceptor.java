package kr.co.dw.interceptor;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.dw.domain.MemberDTO;

public class LogoutHandlerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, 
							HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession(false);
		if(session !=null) {
			session.invalidate();
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
							Object handler,ModelAndView modelAndView) throws Exception {

		

	}
	
	
	

}
