---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }"
---

    public <%= propertyType %> get<%= h.changeCase.pascal(propertyName) %>() { return <%= propertyName %>; }
    public void set<%= h.changeCase.pascal(propertyName) %>(<%= propertyType %> <%= propertyName %>) { this.<%= propertyName %> = <%= propertyName %>; }