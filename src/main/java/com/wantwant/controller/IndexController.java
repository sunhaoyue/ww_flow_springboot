package com.wantwant.controller;

import io.swagger.annotations.Api;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * create by sunhaoyue 2019/06/12
 */
@Controller
@Api(tags="LoginController",description = "登录管理")
public class IndexController {

    @RequestMapping("/index")
    public String index() {
        return "thymeleaf/index";
    }


    @RequestMapping("/login")
    public String login() {
        return "jsp/login";
    }

    @RequestMapping("/showdb")
    public String showDB() {
        return "showDB";
    }
}




