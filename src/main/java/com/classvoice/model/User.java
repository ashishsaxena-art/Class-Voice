package com.classvoice.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class User implements Serializable {
    private long userId; private String name; private String email; private String password; private String role; private LocalDateTime createdAt;
    public long getUserId(){return userId;} public void setUserId(long v){userId=v;}
    public String getName(){return name;} public void setName(String v){name=v;}
    public String getEmail(){return email;} public void setEmail(String v){email=v;}
    public String getPassword(){return password;} public void setPassword(String v){password=v;}
    public String getRole(){return role;} public void setRole(String v){role=v;}
    public LocalDateTime getCreatedAt(){return createdAt;} public void setCreatedAt(LocalDateTime v){createdAt=v;}
}
