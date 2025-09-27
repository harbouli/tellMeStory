---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= moduleName %>RepositoryAdapter.java
skip_if: <%= !features.includes('repository') %>
---
package com.tellmestory.infrastructure.adapters.out.persistence;

import com.tellmestory.application.ports.out.<%= moduleName %>Repository;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>Id;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
public class <%= moduleName %>RepositoryAdapter implements <%= moduleName %>Repository {
    private final <%= moduleName %>JpaRepository <%= h.changeCase.lower(moduleName) %>JpaRepository;
    private final <%= moduleName %>Mapper <%= h.changeCase.lower(moduleName) %>Mapper;

    public <%= moduleName %>RepositoryAdapter(<%= moduleName %>JpaRepository <%= h.changeCase.lower(moduleName) %>JpaRepository, 
                                 <%= moduleName %>Mapper <%= h.changeCase.lower(moduleName) %>Mapper) {
        this.<%= h.changeCase.lower(moduleName) %>JpaRepository = <%= h.changeCase.lower(moduleName) %>JpaRepository;
        this.<%= h.changeCase.lower(moduleName) %>Mapper = <%= h.changeCase.lower(moduleName) %>Mapper;
    }

    @Override
    public <%= moduleName %> save(<%= moduleName %> <%= h.changeCase.lower(moduleName) %>) {
        <%= moduleName %>Entity entity = <%= h.changeCase.lower(moduleName) %>Mapper.toEntity(<%= h.changeCase.lower(moduleName) %>);
        <%= moduleName %>Entity savedEntity = <%= h.changeCase.lower(moduleName) %>JpaRepository.save(entity);
        return <%= h.changeCase.lower(moduleName) %>Mapper.toDomain(savedEntity);
    }

    @Override
    public Optional<<%= moduleName %>> findById(<%= moduleName %>Id id) {
        return <%= h.changeCase.lower(moduleName) %>JpaRepository.findById(id.getValue())
                .map(<%= h.changeCase.lower(moduleName) %>Mapper::toDomain);
    }

    @Override
    public List<<%= moduleName %>> findAll() {
        return <%= h.changeCase.lower(moduleName) %>JpaRepository.findAll()
                .stream()
                .map(<%= h.changeCase.lower(moduleName) %>Mapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(<%= moduleName %>Id id) {
        <%= h.changeCase.lower(moduleName) %>JpaRepository.deleteById(id.getValue());
    }
}