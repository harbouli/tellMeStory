---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "LocalDateTime updatedAt\\) \\{"
---
                <%= propertyType %> <%= propertyName %>,