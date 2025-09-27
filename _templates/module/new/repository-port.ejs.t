---
to: src/main/java/com/tellmestory/application/ports/out/<%= moduleName %>Repository.java
skip_if: <%= !features.includes('repository') %>
---
package com.tellmestory.application.ports.out;

import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>Id;
import java.util.List;
import java.util.Optional;

public interface <%= moduleName %>Repository {
    <%= moduleName %> save(<%= moduleName %> <%= h.changeCase.lower(moduleName) %>);
    Optional<<%= moduleName %>> findById(<%= moduleName %>Id id);
    List<<%= moduleName %>> findAll();
    void deleteById(<%= moduleName %>Id id);
}