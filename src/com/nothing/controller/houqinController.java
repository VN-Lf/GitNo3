package com.nothing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("houqin")
public class houqinController {
    @RequestMapping("/toRepair")
    public String toRepair(){
        return "repairList";
    }
}
