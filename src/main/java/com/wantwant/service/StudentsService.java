package com.wantwant.service;

import com.wantwant.dao.StudentsRepository;
import com.wantwant.pojo.Students;

public class StudentsService  implements StudentsRepository {
    @Override
    public Students getStudents(String id) {
        System.out.println(id+"进入实现类获取数据！");
        Students students=new Students();
        students.setId(id);
        students.setName("sunhaoyue");
        students.setAge(24);
        students.setGender("男");
        return students;
    }

    @Override
    public void deleteUser(String id) {
        System.out.println(id+"进入实现类删除数数据！");

    }
}
