/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.web.util.CookieUtil;

@Controller("indexController")
public class IndexController
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	/**
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public String index(HttpServletRequest request, HttpServletResponse response)
	{
		return "/index";
	}
	
	@RequestMapping(value = "/index2", method=RequestMethod.GET)
	public String index2(HttpServletRequest request, HttpServletResponse response)
	{
		return "/index2";
	}
}
