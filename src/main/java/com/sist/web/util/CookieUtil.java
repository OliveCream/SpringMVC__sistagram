/**
 * <pre>
 * 프로젝트명 : BasicBoard
 * 패키지명   : com.icia.web.util
 * 파일명     : CookieUtil.java
 * 작성일     : 2021. 1. 12.
 * 작성자     : daekk
 * </pre>
 */
package com.sist.web.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.common.util.StringUtil;

public final class CookieUtil
{
	private CookieUtil() {}

	/**
	 * @param response javax.servlet.http.HttpServletResponse
	 * @param domain   쿠키의 유효한 도메인 설정
	 * @param path     쿠키의 유효한 디렉토리를 설정 
	 * @param maxAge   쿠키의 상태 유지시간 - 초단위 설정(-1 이면 브라우저가 종료되면 사라짐)
	 * @param name     쿠키 이름
	 * @param value    쿠키 값
	 * @param charset  캐릭터 셋
	 * @return boolean
	 */
	public static boolean addCookie(HttpServletResponse response, String domain, String path, int maxAge, String name, String value, String charset)
	{
		boolean bFlag = false;
		
		if(!StringUtil.isEmpty(name))
		{
			try
			{
				if(StringUtil.isEmpty(charset))
				{
					charset = "UTF-8";
				}
				
				if(!StringUtil.isEmpty(value))
				{
					value = URLEncoder.encode(value, charset);
				}
								
				Cookie cookie = new Cookie(name, value);
				
				if(maxAge != 0)
				{
					// 1분:60, 10분:60*10, 1시간:60*60, 1일:60*60*24
					cookie.setMaxAge(maxAge);
				}
				
				if(!StringUtil.isEmpty(path))
				{
					cookie.setPath(path);
				}
				
				if(!StringUtil.isEmpty(domain))
				{
					cookie.setDomain(domain);
				}
				
				response.addCookie(cookie);
				
				bFlag = true;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return bFlag;
	}
	
	/**
	 * @param response javax.servlet.http.HttpServletResponse
	 * @param path     쿠키의 유효한 디렉토리를 설정
	 * @param maxAge   쿠키의 상태 유지시간 - 초단위 설정(-1 이면 브라우저가 종료되면 사라짐)
	 * @param name     쿠키 이름
	 * @param value    쿠키 값
	 * @return boolean
	 */
	public static boolean addCookie(HttpServletResponse response, String path, int maxAge, String name, String value)
	{
		return addCookie(response, "", path, maxAge, name, value, "UTF-8");
	}
	
	/**
	 * @param response javax.servlet.http.HttpServletResponse
	 * @param maxAge   쿠키의 상태 유지시간 - 초단위 설정(-1 이면 브라우저가 종료되면 사라짐)
	 * @param name     쿠키 이름
	 * @param value    쿠키 값
	 * @return boolean
	 */
	public static boolean addCookie(HttpServletResponse response, int maxAge, String name, String value)
	{
		return addCookie(response, "", "", maxAge, name, value, "UTF-8");
	}
	
	/**
	 * @param response javax.servlet.http.HttpServletResponse
	 * @param name     쿠키 이름
	 * @param value    쿠키 값
	 * @return boolean
	 */
	public static boolean addCookie(HttpServletResponse response, String name, String value)
	{
		return addCookie(response, "", "", -1, name, value, "UTF-8");
	}
	
	/**
	 * @param request javax.servlet.http.HttpServletRequest 
	 * @param name 쿠키 이름
	 * @return javax.servlet.http.Cookie
	 */
	public static Cookie getCookie(HttpServletRequest request, String name)
	{
		if(!StringUtil.isEmpty(name))
		{
			Cookie[] cookies = request.getCookies();
			
    		if(cookies != null)
    		{
    			for(int i=0; i<cookies.length; i++)
    			{
    				if(cookies[i] != null)
    				{
	    				if(StringUtil.equals(cookies[i].getName(), name))
	    				{
	    					return cookies[i];
	    				}
    				}
    			}
    		}
		}
		
		return null;
	}
	
	/**
	 * @param request javax.servlet.http.HttpServletRequest 
	 * @param name    쿠키 이름
	 * @return String
	 */
	public static String getValue(HttpServletRequest request, String name)
	{
		return getValue(request, name, "UTF-8");
	}
	
	/**
	 * @param request javax.servlet.http.HttpServletRequest 
	 * @param name    쿠키 이름
	 * @param charset 캐릭터 셋
	 * @return String
	 */
	public static String getValue(HttpServletRequest request, String name, String charset)
	{
		Cookie cookie = getCookie(request, name);
		
		if(cookie != null && !StringUtil.isEmpty(cookie.getValue()))
		{
			try
			{
				if(StringUtil.isEmpty(charset))
				{
					charset = "UTF-8";
				}
				
				return URLDecoder.decode(cookie.getValue(), charset);
			}
			catch(UnsupportedEncodingException e)
			{
				return "";
			}
		}
		else
		{
			return "";
		}
	}
	
	/**
	 * @param request javax.servlet.http.HttpServletRequest 
	 * @param name    쿠키 이름
	 * @return String
	 */
	public static String getHexValue(HttpServletRequest request, String name)
	{
		return getHexValue(request, name, "UTF-8");
	}
	
	/**
	 * @param request javax.servlet.http.HttpServletRequest 
	 * @param name    쿠키 이름
	 * @param charset 캐릭터 셋
	 * @return String
	 */
	public static String getHexValue(HttpServletRequest request, String name, String charset)
	{
		Cookie cookie = getCookie(request, name);
		
		if(cookie != null && !StringUtil.isEmpty(cookie.getValue()))
		{
			try
			{
				if(StringUtil.isEmpty(charset))
				{
					charset = "UTF-8";
				}
				
				return hexToString(URLDecoder.decode(cookie.getValue(), charset));
			}
			catch(UnsupportedEncodingException e)
			{
				return "";
			}
		}
		else
		{
			return "";
		}
	}
	
	/**
	 * @param request  javax.servlet.http.HttpServletRequest 
	 * @param response javax.servlet.http.HttpServletResponse 
	 * @param domain   쿠키의 유효한 도메인 설정
	 * @param path     쿠키의 유효한 디렉토리를 설정
	 * @param name     쿠키 이름
	 * @return boolean
	 */
	public static boolean deleteCookie(HttpServletRequest request, HttpServletResponse response, String domain, String path, String name)
	{
		/*
		 * 쿠키 관리는 웹 클라이언트가 하기 때문에 쿠키를 삭제하는 명령어는 없다. 
		 * 쿠키를 삭제하기 위해서는 쿠기의 maxAge(상태 유지시간 - 초단위 설정)를 0으로 만들어서 전송하면 된다.
		 */
		if(!StringUtil.isEmpty(name))
		{
			Cookie cookie = getCookie(request, name);
			
			if(cookie != null)
			{
				cookie.setMaxAge(0);
				
				if(!StringUtil.isEmpty(domain))
				{
					cookie.setDomain(domain);
				}
				
				if(!StringUtil.isEmpty(path))
				{
					cookie.setPath(path);
				}
				
				response.addCookie(cookie);
				
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * @param request  javax.servlet.http.HttpServletRequest 
	 * @param response javax.servlet.http.HttpServletResponse 
	 * @param path     쿠키의 유효한 디렉토리를 설정
	 * @param name     쿠키 이름
	 * @return boolean
	 */
	public static boolean deleteCookie(HttpServletRequest request, HttpServletResponse response, String path, String name)
	{
		return deleteCookie(request, response, "", path, name);
	}
	
	/**
	 * @param request  javax.servlet.http.HttpServletRequest 
	 * @param response javax.servlet.http.HttpServletResponse 
	 * @param name     쿠키 이름
	 * @return boolean
	 */
	public static boolean deleteCookie(HttpServletRequest request, HttpServletResponse response, String name)
	{
		return deleteCookie(request, response, "", "", name);
	}
	
	/**
	 * @param hex 헥사 문자열
	 * @return String
	 */
	public static String hexToString(String hex)
	{
		return hexToString(hex, "UTF-8");
	}
	
	/**
	 * @param hex 헥사 문자열
	 * @param charset 캐릭터 셋
	 * @return String
	 */
	public static String hexToString(String hex, String charset)
	{
		if (hex != null)
		{
			if(StringUtil.isEmpty(charset))
			{
				charset = "UTF-8";
			}
			
			byte[] bytes = new byte[hex.length() / 2];
			
			for (int i = 0; i < bytes.length; i++)
			{
				bytes[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
			}
			
			try
			{
				return (new String(bytes, charset));
			}
			catch (UnsupportedEncodingException e)
			{
				return null; 
			}
		}
		
		return null;
	}
	
	/**
	 * @param value 문자열
	 * @return String
	 */
	public static String stringToHex(String value)
	{
		return stringToHex(value, "UTF-8");
	}

	/**
	 * @param value 문자열
	 * @param charset 캐릭터셋
	 * @return String
	 */
	public static String stringToHex(String value, String charset)
	{
		if(value != null)
		{
			try
			{
				byte[] bytes = null;
				
				if(StringUtil.isEmpty(charset))
				{
					charset = "UTF-8";
				}
				
				bytes = value.getBytes(charset);
				
				StringBuffer sb = new StringBuffer(bytes.length * 2);
				String hexNumber;
		
				for (int x = 0; x < bytes.length; x++)
				{
					hexNumber = "0" + Integer.toHexString(0xff & bytes[x]);
					sb.append(hexNumber.substring(hexNumber.length() - 2));
				}
		
				return sb.toString();
			}
			catch(Exception e)
			{
				return null;
			}
		}
		
		return null;
	}
}
