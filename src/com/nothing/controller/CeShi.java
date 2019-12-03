package com.nothing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ce")
public class CeShi {
    @RequestMapping("/login")
    public String login(){
        return "ceshi";
    }
}