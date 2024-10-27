/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.util
 * 파일명     : JsonUtil.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * </pre>
 */
package com.sist.web.util;

import java.lang.reflect.Type;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.sist.common.util.StringUtil;

/**
 * <pre>
 * 설명 : JSON 유틸리티 (gson 사용)
 */
public final class JsonUtil
{
	private static final Logger logger = LoggerFactory.getLogger(JsonUtil.class);
	
	private JsonUtil() {}
	
	/**
	 * 메소드명 : toJson
	 * 설명 : 객체를 json 문자열로 변환한다.
	 * @param object Object
	 * @return Strijng
	 */
	public static String toJson(Object object)
	{
		if(object == null)
		{
			return null;
		}
		
		return GsonFactory.createDefaultGson().toJson(object);
	}
	
	/**
	 * 메소드명 : toJsonPretty
	 * 설명 : 객체를 json pretty format 문자열로 변환한다.
	 * @param object 객체
	 * @return String
	 */
	public static String toJsonPretty(Object object)
	{
		if(object == null)
		{
			return "{}";
		}
		
		return GsonFactory.createPrettyGson().toJson(object);
	}
	
	/**
	 * <pre>
	 * 메소드명 : fromJson
	 * 설명 : json 문자열을 객체로 변환 한다.
	 * @param json json문자열
	 * @param cls java.lang.Class<T>
	 * @return <T>
	 */
	public static <T> T fromJson(String json, Class<T> cls)
	{
		if(json != null && json.length() > 0 && cls != null)
		{
			try
			{
				return GsonFactory.createDefaultGson().fromJson(json, cls);
			}
			catch(Exception e)
			{
				logger.error("[JsonUtil] fromJson JsonSyntaxException : " + e.getMessage(), e);
			}
		}
		
		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명 : fromJson
	 * 설명 : json 문자열을 객체로 변환 한다.
	 *		 ex) type : new TypeToken<ArrayList<YourClass>>(){}.getType()
	 * @param json json문자열
	 * @param type java.lang.reflect.Type
	 * @return
	 */
	public static <T> T fromJson(String json, Type type)
	{
		if(json != null && json.length() > 0 && type != null)
		{
			try
			{
				return GsonFactory.createDefaultGson().fromJson(json, type);
			}
			catch(JsonSyntaxException e)
			{
				logger.error("[JsonUtil] fromJson JsonSyntaxException : " + e.getMessage(), e);
			}
		}
		
		return null;
	}
	
	/**
	 * 메소드명 : jsonStringToPretty
	 * 설명 : json 문자열을 pretty format으로 변환한다.
	 * @param jsonString
	 * @return
	 */
	public static String jsonStringToPretty(String jsonString)
	{
		if(StringUtil.isEmpty(jsonString))
		{
			return "{}";
		}
		else
		{
			JsonObject jsonObject = GsonFactory.createDefaultGson().fromJson(jsonString, JsonObject.class);
			
	        return GsonFactory.createPrettyGson().toJson(jsonObject);
		}
	}
	
	public static <T> JsonArray listToJsonArray(List<T> list)
	{
		if(list != null)
		{
			try
			{
				return GsonFactory.createDefaultGson().toJsonTree(list).getAsJsonArray();
			}
			catch(Exception e)
			{
				logger.error("[JsonUtil] listToJsonArray Exception : " + e.getMessage(), e);
			}
		}
		
		return null;
	}

	public static class GsonFactory 
	{
        public static Gson createDefaultGson() 
        {
        	return new GsonBuilder().serializeNulls().create();
        }

        public static Gson createPrettyGson() 
        {
            return new GsonBuilder().serializeNulls().setPrettyPrinting().create();
        }
    }
}
