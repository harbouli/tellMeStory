---
to: src/main/java/com/tellmestory/application/services/<%= moduleName %>Service.java
skip_if: <%= !features.includes('service') %>
---
package com.tellmestory.application.services;

import com.tellmestory.application.ports.in.Create<%= moduleName %>Command;
import com.tellmestory.application.ports.in.Create<%= moduleName %>UseCase;
import com.tellmestory.application.ports.in.Get<%= moduleName %>sQuery;
import com.tellmestory.application.ports.out.<%= moduleName %>Repository;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>Id;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class <%= moduleName %>Service implements Create<%= moduleName %>UseCase, Get<%= moduleName %>sQuery {
    
    private final <%= moduleName %>Repository <%= h.changeCase.lower(moduleName) %>Repository;

    public <%= moduleName %>Service(<%= moduleName %>Repository <%= h.changeCase.lower(moduleName) %>Repository) {
        this.<%= h.changeCase.lower(moduleName) %>Repository = <%= h.changeCase.lower(moduleName) %>Repository;
    }

    @Override
    public <%= moduleName %> create<%= moduleName %>(Create<%= moduleName %>Command command) {
        LocalDateTime now = LocalDateTime.now();
        
        <%= moduleName %> <%= h.changeCase.lower(moduleName) %> = new <%= moduleName %>(
                <%= moduleName %>Id.generate(),
                command.name(),
                command.description(),
                now,
                now
        );

        return <%= h.changeCase.lower(moduleName) %>Repository.save(<%= h.changeCase.lower(moduleName) %>);
    }

    @Override
    public List<<%= moduleName %>> getAll<%= moduleName %>s() {
        return <%= h.changeCase.lower(moduleName) %>Repository.findAll();
    }

    @Override
    public Optional<<%= moduleName %>> get<%= moduleName %>ById(String id) {
        return <%= h.changeCase.lower(moduleName) %>Repository.findById(<%= moduleName %>Id.of(id));
    }
}