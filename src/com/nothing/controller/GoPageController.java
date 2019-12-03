package com.nothing.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *转跳页面总控制器 登录判断
 */
@Controller
@RequestMapping("to")
public class GoPageController {
    @RequestMapping("/home")
    public String toHome(){
        return "home";
    }
}
