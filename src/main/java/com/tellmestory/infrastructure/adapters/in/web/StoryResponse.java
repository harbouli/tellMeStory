package com.tellmestory.infrastructure.adapters.in.web;

import java.time.LocalDateTime;

public record StoryResponse(
    String id,
    String title,
    String content,
    String authorId,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {}