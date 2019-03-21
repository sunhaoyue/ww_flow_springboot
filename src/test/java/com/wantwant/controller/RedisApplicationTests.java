package com.wantwant.controller;

import com.wantwant.pojo.Students;
import com.wantwant.service.StudentsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest
public class RedisApplicationTests {

    @Autowired
    private StringRedisTemplate template;

    @Autowired
    private StudentsService studentsService;

    @Test
    public void get() {
        //template.opsForValue().set("test", "我是地瓜");
        System.out.println(template.opsForValue().get("test"));
    }
    @Test
    public void contextLoads() {
        Students students = new Students();
        students.setId("1");
        students.setAge(12);
        students.setName("张三");
        students.setGender("男");
        template.opsForValue().append("date", students.toString());
        System.out.println(template.opsForValue().get("date"));
    }
    @Test
    public void getStudents() {
        for (int i = 0; i < 10; i++) {
            Students students = studentsService.getStudents(String.valueOf(i));
            System.out.println(students);
        }
    }
}
