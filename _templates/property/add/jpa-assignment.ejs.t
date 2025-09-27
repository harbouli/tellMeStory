---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "this\\.updatedAt = updatedAt;"
---
        this.<%= propertyName %> = <%= propertyName %>;