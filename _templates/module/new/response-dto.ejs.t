---
to: src/main/java/com/tellmestory/infrastructure/adapters/in/web/<%= moduleName %>Response.java
skip_if: <%= !features.includes('controller') %>
---
package com.tellmestory.infrastructure.adapters.in.web;

import java.time.LocalDateTime;

public record <%= moduleName %>Response(
    String id,
    String name,
    String description,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {}