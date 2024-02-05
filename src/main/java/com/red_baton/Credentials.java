package com.red_baton;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Credentials {
    @Id
    @Column(nullable = false)
    public String Username;
    @Column(nullable = false)
    public String Password;

    Credentials() {
    }

    public Credentials(String username, String password) {
        this.Username = username;
        this.Password = password;
    }

    public String getUsername() {
        return this.Username;
    }

    public void setUsername(String username) {
        this.Username = username;
    }

    public String getPassword() {
        return this.Password;
    }

    public void setPassword(String password) {
        this.Password = password;
    }
}
