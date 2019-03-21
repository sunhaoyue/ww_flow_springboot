package com.wantwant.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface ResultRepository {

    @Transactional
    @Modifying
    @Query(value = "insert into result(ticket_id,user_id) values(?1,?2)", nativeQuery = true)
    default void add(@Param("ticketID") Integer ticketID, @Param("userId") Integer userId) {

    }
    Result findByUserId(Integer userId);
}
