package com.kst.activiti.ext;

import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.interceptor.Session;
import org.activiti.engine.impl.interceptor.SessionFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author zjf
 * @Date 2018.08.14
 */
@Service
public class GroupEntityFactory implements SessionFactory {
	@Override
	public Class<?> getSessionType() {
		return null;
	}

	@Override
	public Session openSession(CommandContext commandContext) {
		return null;
	}

//	@Autowired
//	GroupEntityManager groupEntityManager;
//
//	@Override
//	public Class<?> getSessionType() {
//		return GroupIdentityManager.class;
//	}
//
//	@Override
//	public Session openSession() {
//		return groupEntityManager;
//	}
}
