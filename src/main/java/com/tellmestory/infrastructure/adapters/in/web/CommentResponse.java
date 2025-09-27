package com.tellmestory.infrastructure.adapters.in.web;

import java.time.LocalDateTime;

public record CommentResponse(
    String id,
    String name,
    String description,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {}