package com.wantwant.dao;

import com.wantwant.pojo.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Long> {
    User findByName(String name);
    User findByNameOrMail(String name,String mail);
}
