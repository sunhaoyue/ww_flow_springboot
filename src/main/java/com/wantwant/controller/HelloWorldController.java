package com.wantwant.controller;


import com.wantwant.pojo.User;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    @RequestMapping("/hello")
    public String index(){
        return "hello world";
    }

    @RequestMapping("/getuser")
    public User getUser(){
        User user = new User();
        return user;
    }
}
