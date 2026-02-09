package com.iamneo.studentms.Model;

public class studentModel {
    private int id;
    private String name;
    private String email;
    private String department;
    private int age;
    private String phone;
    
    public studentModel() {
    }
    
    public studentModel(int id, String name, String email, String department, int age, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.department = department;
        this.age = age;
        this.phone = phone;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getEmail() {
        return email;
    }
    public String getDepartment() {
        return department;
    }
    public int getAge() {
        return age;
    }
    public String getPhone() {
        return phone;
    }
    
}