package com.tellmestory.application.ports.in;

import jakarta.validation.constraints.NotBlank;

public record LoginCommand(
    @NotBlank
    String username,
    
    @NotBlank
    String password
) {}