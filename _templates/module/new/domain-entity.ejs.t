---
to: src/main/java/com/tellmestory/domain/<%= h.changeCase.lower(moduleName) %>/<%= moduleName %>.java
skip_if: <%= !features.includes('domain') %>
---
package com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>;

import java.time.LocalDateTime;
import java.util.Objects;

public class <%= moduleName %> {
    private final <%= moduleName %>Id id;
    private final String name;
    private final String description;
    private final LocalDateTime createdAt;
    private final LocalDateTime updatedAt;

    public <%= moduleName %>(<%= moduleName %>Id id, String name, String description,
                LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = Objects.requireNonNull(id, "<%= moduleName %> ID cannot be null");
        this.name = Objects.requireNonNull(name, "Name cannot be null");
        this.description = description;
        this.createdAt = Objects.requireNonNull(createdAt, "Created at cannot be null");
        this.updatedAt = Objects.requireNonNull(updatedAt, "Updated at cannot be null");
        
        validateName(name);
    }

    private void validateName(String name) {
        if (name.trim().isEmpty() || name.length() > 100) {
            throw new IllegalArgumentException("Name must not be empty and must be at most 100 characters");
        }
    }

    public <%= moduleName %>Id getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        <%= moduleName %> <%= h.changeCase.lower(moduleName) %> = (<%= moduleName %>) o;
        return Objects.equals(id, <%= h.changeCase.lower(moduleName) %>.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}