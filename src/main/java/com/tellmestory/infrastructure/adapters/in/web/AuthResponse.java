package com.tellmestory.infrastructure.adapters.in.web;

import java.time.LocalDateTime;

public record AuthResponse(
    String token,
    String tokenType,
    LocalDateTime expiresAt
) {}