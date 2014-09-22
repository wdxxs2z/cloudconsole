package com.cloudconsole.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cloudconsole.controller.AuthenticatorController;
import com.cloudconsole.controller.LoginController;
/**
 * 实现session的拦截器
 * yuanyuan
 * 2014.09.17
 * */
public class SessionValidate implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		Object client = request.getSession().getAttribute("client");
		if(client == null && !(handler instanceof LoginController) && !(handler instanceof AuthenticatorController)){
			//重定向
			response.sendRedirect(request.getContextPath());
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
