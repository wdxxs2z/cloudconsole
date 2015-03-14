package com.cloudconsole.handler;

import java.util.List;

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
	
	private List<String> excludeUrls;

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		String requestUri = request.getRequestURI();
		for (String uri : excludeUrls) {
			if (requestUri.endsWith(uri)) {
				return true;
			}
		}
		
		Object client = request.getSession().getAttribute("client");
		if(client == null && !(handler instanceof LoginController) && !(handler instanceof AuthenticatorController)){
			response.sendRedirect("login");
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
