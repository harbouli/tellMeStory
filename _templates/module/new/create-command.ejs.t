---
to: src/main/java/com/tellmestory/application/ports/in/Create<%= moduleName %>Command.java
skip_if: <%= !features.includes('dto') %>
---
package com.tellmestory.application.ports.in;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record Create<%= moduleName %>Command(
    @NotBlank
    @Size(max = 100)
    String name,
    
    @Size(max = 500)
    String description
) {}