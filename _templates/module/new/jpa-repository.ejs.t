---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= moduleName %>JpaRepository.java
skip_if: <%= !features.includes('repository') %>
---
package com.tellmestory.infrastructure.adapters.out.persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface <%= moduleName %>JpaRepository extends JpaRepository<<%= moduleName %>Entity, UUID> {
}