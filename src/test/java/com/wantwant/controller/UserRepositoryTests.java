package com.wantwant.controller;

import com.wantwant.dao.UserRepository;
import com.wantwant.pojo.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class UserRepositoryTests {

    @Autowired
    private UserRepository userRepository;

    @Test
    public void test() throws Exception {


        userRepository.save(new User("linux", "44",44,"44@qq.com",24));
        userRepository.save(new User("macos", "55",55,"44@qq.com",24));
        userRepository.save(new User("window", "66",66,"55@qq.com",24));

        userRepository.delete(userRepository.findByName("macos"));

    }

}