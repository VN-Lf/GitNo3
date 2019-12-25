package com.nothing.Interceptor;

import org.omg.PortableInterceptor.Interceptor;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public class jurisdictionIntercepter implements HandlerInterceptor {
    //白名单
    public String[] whiteList = {"/to/toLogin","/to/login","/to/idAble"};

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //通行证
        boolean flag = false;
        //权限列表
        ArrayList<String> ableList = (ArrayList<String>) httpServletRequest.getSession().getAttribute("urlList");
        System.out.println("权限列表："+ableList);
        String requestUri = httpServletRequest.getRequestURI();
        for(String s:whiteList){
            if(requestUri.equals(httpServletRequest.getServletPath()+s)){
                flag = true;
            }
        }
        if(!flag){
            if (ableList.contains(requestUri)){
                return true;
            }else {
                return  false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
