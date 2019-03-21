package com.wantwant.pojo;



import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="user")
public class User implements Serializable {
    private static final  long serialVersionUID=1l;
    @Id
    @GeneratedValue
    private int id;

    @Column(nullable = false,unique = true)
    private String name;

    @Column(nullable = false,unique = true)
    private String password;

    @Column(nullable = false,unique = true)
    private int number;

    @Column(nullable = false,unique = true)
    private String mail;

    @Column(nullable = false,unique = true)
    private int ages;

    public User() {

    }

    public User(String name, String password, int number, String mail, int ages) {
        this.name = name;
        this.password = password;
        this.number = number;
        this.mail = mail;
        this.ages = ages;
    }



    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public int getAges() {
        return ages;
    }

    public void setAges(int ages) {
        this.ages = ages;
    }
}
