package com.tellmestory.infrastructure.adapters.out.security;

import com.tellmestory.application.ports.out.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class SpringPasswordEncoder implements PasswordEncoder {
    
    private final org.springframework.security.crypto.password.PasswordEncoder springPasswordEncoder;

    public SpringPasswordEncoder(org.springframework.security.crypto.password.PasswordEncoder springPasswordEncoder) {
        this.springPasswordEncoder = springPasswordEncoder;
    }

    @Override
    public String encode(String password) {
        return springPasswordEncoder.encode(password);
    }

    @Override
    public boolean matches(String password, String encodedPassword) {
        return springPasswordEncoder.matches(password, encodedPassword);
    }
}