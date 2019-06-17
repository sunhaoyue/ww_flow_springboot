package com.wantwant.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.catalina.User;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @program: ww_flow_springboot
 * @description: ${description}
 * @author: Sunhaoyue
 * @create: 2019/06/13 14:44
 */
@Api(tags="用户管理",description="UserController")
@RestController
@RequestMapping("/user")
public class UserController {

    @ApiOperation(value = "用户申请审核", notes = "用户申请审核")
    @RequestMapping(value="/apply/audit",method= RequestMethod.GET)
    public String applyAudit() {

        return "app";
    }

    @ApiOperation(value = "获取用户详细信息", notes = "根据ID查找用户")
    @ApiImplicitParam(paramType = "query", name = "username", value = "用户名", required = true, dataType = "String")
    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public User get(String username) {
        return null;
    }

    @ApiOperation(value = "修改用户信息", notes = "修改用户信息")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", name = "user", value = "用户实体", required = true, dataType = "user"),
            @ApiImplicitParam(paramType = "query", name = "cname", value = "公司名称", required = true, dataType = "String") })
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public void save(User user, String cname, String curl) {
    }
}