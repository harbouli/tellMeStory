package com.tellmestory.application.ports.out;

import com.tellmestory.domain.auth.AuthToken;
import com.tellmestory.domain.user.User;

public interface TokenGenerator {
    AuthToken generateToken(User user);
    boolean validateToken(String token);
    String getUsernameFromToken(String token);
}