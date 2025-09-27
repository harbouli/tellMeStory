---
to: src/main/java/com/tellmestory/infrastructure/config/SeedConfiguration.java
---
package com.tellmestory.infrastructure.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
<% if (seedEnvironment !== 'all') { -%>
import org.springframework.context.annotation.Profile;
<% } -%>

@Configuration
<% if (seedEnvironment !== 'all') { -%>
@Profile("<%= seedEnvironment %>")
<% } -%>
@ConditionalOnProperty(
    name = "app.seed.enabled",
    havingValue = "true",
    matchIfMissing = false
)
public class SeedConfiguration {
    // Seed configuration will be loaded when app.seed.enabled=true
}