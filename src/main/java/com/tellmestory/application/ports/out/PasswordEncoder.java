package com.tellmestory.application.ports.out;

public interface PasswordEncoder {
    String encode(String password);
    boolean matches(String password, String encodedPassword);
}