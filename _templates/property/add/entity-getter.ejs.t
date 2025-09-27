---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "public LocalDateTime getUpdatedAt\\(\\) \\{ return updatedAt; \\}"
---
    public <%= propertyType %> get<%= h.changeCase.pascal(propertyName) %>() { return <%= propertyName %>; }