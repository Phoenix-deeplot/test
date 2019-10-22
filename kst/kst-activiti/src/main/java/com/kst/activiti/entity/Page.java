package com.kst.activiti.entity;

import java.io.Serializable;

import com.kst.activiti.utils.Const;
import com.kst.activiti.utils.Jurisdiction;
import org.apache.shiro.session.Session;

public class Page implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int showCount;
	private int totalPage;
	private int totalResult;
	private int currentPage;
	private PageData pd = new PageData();
	
	public Page(){
		try {
			Session session = Jurisdiction.getSession();
			this.showCount = null != session.getAttribute(Const.SHOWCOUNT)?Integer.parseInt(session.getAttribute(Const.SHOWCOUNT).toString()):10;
		} catch (Exception e) {
			this.showCount = 10;
		}
	}
	
	public int getTotalPage() {
		if(totalResult%showCount==0)
			totalPage = totalResult/showCount;
		else
			totalPage = totalResult/showCount+1;
		return totalPage;
	}
	
	public int getCurrentPage() {
		if(currentPage<=0)
			currentPage = 1;
		if(currentPage>getTotalPage())
			currentPage = getTotalPage();
		return currentPage;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public PageData getPd() {
		return pd;
	}

	public void setPd(PageData pd) {
		this.pd = pd;
	}
	
}
