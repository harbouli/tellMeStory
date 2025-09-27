---
to: src/main/java/com/tellmestory/application/ports/in/Create<%= moduleName %>UseCase.java
skip_if: <%= !features.includes('service') %>
---
package com.tellmestory.application.ports.in;

import com.tellmestory.domain.<%= h.changeCase.lower(moduleName) %>.<%= moduleName %>;

public interface Create<%= moduleName %>UseCase {
    <%= moduleName %> create<%= moduleName %>(Create<%= moduleName %>Command command);
}