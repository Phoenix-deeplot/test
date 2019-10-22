package com.kst.activiti.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;


public class Jurisdiction {
	

	public static Session getSession(){
		return SecurityUtils.getSubject().getSession();
	}
	public static Subject getUser(){
		return SecurityUtils.getSubject();
	}

	public static String getUsername(){
		return getSession().getAttribute(Const.SESSION_USERNAME).toString();
	}
	

	public static String getName(){
		return getSession().getAttribute(Const.SESSION_U_NAME).toString();
	}
	

	public static String getRnumbers(){
		return getSession().getAttribute(Const.SESSION_RNUMBERS).toString();
	}

}
