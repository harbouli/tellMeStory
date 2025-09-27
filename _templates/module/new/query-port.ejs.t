---
to: src/main/java/com/tellmestory/application/ports/in/Get<%= moduleName %>sQuery.java
skip_if: <%= !features.includes('service') %>
---
package com.tellmestory.application.ports.in;

import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;
import java.util.List;
import java.util.Optional;

public interface Get<%= moduleName %>sQuery {
    List<<%= moduleName %>> getAll<%= moduleName %>s();
    Optional<<%= moduleName %>> get<%= moduleName %>ById(String id);
}