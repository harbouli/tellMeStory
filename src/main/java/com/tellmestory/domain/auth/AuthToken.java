package com.tellmestory.domain.auth;

import java.time.LocalDateTime;
import java.util.Objects;

public class AuthToken {
    private final String token;
    private final String tokenType;
    private final LocalDateTime expiresAt;

    public AuthToken(String token, String tokenType, LocalDateTime expiresAt) {
        this.token = Objects.requireNonNull(token, "Token cannot be null");
        this.tokenType = Objects.requireNonNull(tokenType, "Token type cannot be null");
        this.expiresAt = Objects.requireNonNull(expiresAt, "Expires at cannot be null");
    }

    public String getToken() { return token; }
    public String getTokenType() { return tokenType; }
    public LocalDateTime getExpiresAt() { return expiresAt; }

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AuthToken authToken = (AuthToken) o;
        return Objects.equals(token, authToken.token);
    }

    @Override
    public int hashCode() {
        return Objects.hash(token);
    }
}