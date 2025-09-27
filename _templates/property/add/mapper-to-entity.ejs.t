---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Mapper.java
inject: true
after: "<%= entity.toLowerCase() %>\\.getUpdatedAt\\(\\)"
---
                <%= entity.toLowerCase() %>.get<%= h.changeCase.pascal(propertyName) %>(),