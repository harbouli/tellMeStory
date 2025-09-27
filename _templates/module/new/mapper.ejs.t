---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= moduleName %>Mapper.java
skip_if: <%= !features.includes('repository') %>
---
package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>Id;
import org.springframework.stereotype.Component;

@Component
public class <%= moduleName %>Mapper {
    
    public <%= moduleName %>Entity toEntity(<%= moduleName %> <%= h.changeCase.lower(moduleName) %>) {
        return new <%= moduleName %>Entity(
                <%= h.changeCase.lower(moduleName) %>.getId().getValue(),
                <%= h.changeCase.lower(moduleName) %>.getName(),
                <%= h.changeCase.lower(moduleName) %>.getDescription(),
                <%= h.changeCase.lower(moduleName) %>.getCreatedAt(),
                <%= h.changeCase.lower(moduleName) %>.getUpdatedAt()
        );
    }

    public <%= moduleName %> toDomain(<%= moduleName %>Entity entity) {
        return new <%= moduleName %>(
                new <%= moduleName %>Id(entity.getId()),
                entity.getName(),
                entity.getDescription(),
                entity.getCreatedAt(),
                entity.getUpdatedAt()
        );
    }
}