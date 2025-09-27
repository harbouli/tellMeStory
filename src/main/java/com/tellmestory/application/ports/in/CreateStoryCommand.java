package com.tellmestory.application.ports.in;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreateStoryCommand(
    @NotBlank
    @Size(max = 200)
    String title,
    
    @NotBlank
    @Size(max = 10000)
    String content,
    
    String authorId
) {}