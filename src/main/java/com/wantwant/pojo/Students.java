package com.wantwant.pojo;


import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="students")
public class Students implements Serializable {
    private static final long serialVersionUID=1l;
    @Id
    @GeneratedValue
    private String id;

    @Column(nullable = false,unique = true)
    private String name;

    @Column(nullable = false,unique = true)
    private int age;

    @Column(nullable = false,unique = true)
    private String gender;

    public Students() {
        super();
    }

    public Students(String id, String name, int age, String gender) {
        super();
        this.id = id;
        this.name = name;
        this.age = age;
        this.gender = gender;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "students{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                '}';
    }
}
