---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "LocalDateTime updatedAt) {"
---
                      <%= propertyType %> <%= propertyName %>,