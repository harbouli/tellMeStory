---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Mapper.java
inject: true
after: "entity\\.getUpdatedAt\\(\\)"
---
                entity.get<%= h.changeCase.pascal(propertyName) %>(),