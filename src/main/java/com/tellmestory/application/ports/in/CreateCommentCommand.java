package com.tellmestory.application.ports.in;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreateCommentCommand(
    @NotBlank
    @Size(max = 100)
    String name,
    
    @Size(max = 500)
    String description
) {}