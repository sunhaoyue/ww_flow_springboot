package com.wantwant.dao;

import com.wantwant.pojo.Students;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;


public interface StudentsRepository {

    @Cacheable(key="'students_'+#id",value = "'students'+#id")
    Students getStudents(String id);

    @CacheEvict(key="'students_'+#id", value="students", condition="#id!=1")
    void deleteUser(String id);

}
