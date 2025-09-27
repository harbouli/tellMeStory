package com.tellmestory.infrastructure.adapters.in.web;

import java.time.LocalDateTime;

public record UserResponse(
    String id,
    String username,
    String email,
    LocalDateTime createdAt
) {}