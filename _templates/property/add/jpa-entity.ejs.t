---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "private LocalDateTime updatedAt;"
---

    @Column(name = "<%= columnName || h.changeCase.snake(propertyName) %>"<% if (!nullable) { %>, nullable = false<% } %><% if (unique) { %>, unique = true<% } %><% if (length && propertyType === 'String') { %>, length = <%= length %><% } %>)
    private <%= propertyType %> <%= propertyName %>;