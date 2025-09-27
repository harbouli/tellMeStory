---
to: src/main/java/com/tellmestory/domain/<%= h.changeCase.lower(moduleName) %>/<%= moduleName %>Id.java
skip_if: <%= !features.includes('domain') %>
---
package com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>;

import java.util.Objects;
import java.util.UUID;

public class <%= moduleName %>Id {
    private final UUID value;

    public <%= moduleName %>Id(UUID value) {
        this.value = Objects.requireNonNull(value, "<%= moduleName %> ID value cannot be null");
    }

    public static <%= moduleName %>Id generate() {
        return new <%= moduleName %>Id(UUID.randomUUID());
    }

    public static <%= moduleName %>Id of(String value) {
        return new <%= moduleName %>Id(UUID.fromString(value));
    }

    public UUID getValue() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        <%= moduleName %>Id <%= h.changeCase.lower(moduleName) %>Id = (<%= moduleName %>Id) o;
        return Objects.equals(value, <%= h.changeCase.lower(moduleName) %>Id.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }

    @Override
    public String toString() {
        return value.toString();
    }
}