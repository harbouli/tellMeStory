---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "private final LocalDateTime updatedAt;"
---
    private final <%= propertyType %> <%= propertyName %>;