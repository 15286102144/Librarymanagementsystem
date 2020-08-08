package com.group.utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ServletContextListenerImpl implements ServletContextListener {
    public void contextDestroyed(ServletContextEvent event) {
        ServletContext application = event.getServletContext();
        application.removeAttribute("onLineNum");
    }
    public void contextInitialized(ServletContextEvent event) {
//利用servletContextEvent对象创建servletContext
        System.out.println(222);
        int num = 0;
        ServletContext application = event.getServletContext();
        application.setAttribute("onLineNum", num);//初始默认在线人数为0
    }
}
