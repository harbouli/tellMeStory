package com.tellmestory.application.ports.in;

import com.tellmestory.domain.auth.AuthToken;

public interface AuthenticationUseCase {
    AuthToken login(LoginCommand command);
    void logout(String token);
    boolean validateToken(String token);
}