---
to: src/main/java/com/tellmestory/infrastructure/adapters/in/web/<%= moduleName %>Controller.java
skip_if: <%= !features.includes('controller') %>
---
package com.tellmestory.infrastructure.adapters.in.web;

import com.tellmestory.application.ports.in.Create<%= moduleName %>UseCase;
import com.tellmestory.application.ports.in.Create<%= moduleName %>Command;
import com.tellmestory.application.ports.in.Get<%= moduleName %>sQuery;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/<%= h.changeCase.kebab(moduleName) %>s")
public class <%= moduleName %>Controller {
    private final Create<%= moduleName %>UseCase create<%= moduleName %>UseCase;
    private final Get<%= moduleName %>sQuery get<%= moduleName %>sQuery;

    public <%= moduleName %>Controller(Create<%= moduleName %>UseCase create<%= moduleName %>UseCase, 
                         Get<%= moduleName %>sQuery get<%= moduleName %>sQuery) {
        this.create<%= moduleName %>UseCase = create<%= moduleName %>UseCase;
        this.get<%= moduleName %>sQuery = get<%= moduleName %>sQuery;
    }

    @PostMapping
    public ResponseEntity<<%= moduleName %>Response> create<%= moduleName %>(@Valid @RequestBody Create<%= moduleName %>Command command) {
        <%= moduleName %> <%= h.changeCase.lower(moduleName) %> = create<%= moduleName %>UseCase.create<%= moduleName %>(command);
        return ResponseEntity.ok(new <%= moduleName %>Response(
                <%= h.changeCase.lower(moduleName) %>.getId().toString(),
                <%= h.changeCase.lower(moduleName) %>.getName(),
                <%= h.changeCase.lower(moduleName) %>.getDescription(),
                <%= h.changeCase.lower(moduleName) %>.getCreatedAt(),
                <%= h.changeCase.lower(moduleName) %>.getUpdatedAt()
        ));
    }

    @GetMapping
    public ResponseEntity<List<<%= moduleName %>Response>> getAll<%= moduleName %>s() {
        List<<%= moduleName %>> <%= h.changeCase.lower(moduleName) %>s = get<%= moduleName %>sQuery.getAll<%= moduleName %>s();
        List<<%= moduleName %>Response> responses = <%= h.changeCase.lower(moduleName) %>s.stream()
                .map(<%= h.changeCase.lower(moduleName) %> -> new <%= moduleName %>Response(
                        <%= h.changeCase.lower(moduleName) %>.getId().toString(),
                        <%= h.changeCase.lower(moduleName) %>.getName(),
                        <%= h.changeCase.lower(moduleName) %>.getDescription(),
                        <%= h.changeCase.lower(moduleName) %>.getCreatedAt(),
                        <%= h.changeCase.lower(moduleName) %>.getUpdatedAt()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(responses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<<%= moduleName %>Response> get<%= moduleName %>ById(@PathVariable String id) {
        return get<%= moduleName %>sQuery.get<%= moduleName %>ById(id)
                .map(<%= h.changeCase.lower(moduleName) %> -> ResponseEntity.ok(new <%= moduleName %>Response(
                        <%= h.changeCase.lower(moduleName) %>.getId().toString(),
                        <%= h.changeCase.lower(moduleName) %>.getName(),
                        <%= h.changeCase.lower(moduleName) %>.getDescription(),
                        <%= h.changeCase.lower(moduleName) %>.getCreatedAt(),
                        <%= h.changeCase.lower(moduleName) %>.getUpdatedAt()
                )))
                .orElse(ResponseEntity.notFound().build());
    }
}