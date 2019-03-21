package com;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("testbean")
public class TestBean {

    @RequestMapping("login")
    public String TeatDemo(){
        return "/pages/login";
    }
}
