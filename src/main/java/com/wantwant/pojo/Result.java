package com.wantwant.pojo;


import sun.plugin2.message.Serializer;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="result")
public class Result implements Serializable {
    @Id
    @GeneratedValue
    private int id;
    @Column(nullable = false,unique = true)
    private int ticket_id;
    @Column(nullable = false,unique = true)
    private int user_id;

    public Result(int id, int ticket_id, int user_id) {
        this.id = id;
        this.ticket_id = ticket_id;
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Result{" +
                "id=" + id +
                ", ticket_id=" + ticket_id +
                ", user_id=" + user_id +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTicket_id() {
        return ticket_id;
    }

    public void setTicket_id(int ticket_id) {
        this.ticket_id = ticket_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
}
