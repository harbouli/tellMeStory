---
to: src/main/java/com/tellmestory/infrastructure/adapters/in/web/SeedController.java
---
package com.tellmestory.infrastructure.adapters.in.web;

import com.tellmestory.infrastructure.config.seed.<%= seedName %>Seeder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
<% if (seedEnvironment !== 'all') { -%>
import org.springframework.context.annotation.Profile;
<% } -%>

<% if (seedEnvironment !== 'all') { -%>
@Profile("<%= seedEnvironment %>")
<% } -%>
@RestController
@RequestMapping("/api/admin/seed")
public class SeedController {

    private final <%= seedName %>Seeder <%= h.changeCase.camel(seedName) %>Seeder;

    public SeedController(<%= seedName %>Seeder <%= h.changeCase.camel(seedName) %>Seeder) {
        this.<%= h.changeCase.camel(seedName) %>Seeder = <%= h.changeCase.camel(seedName) %>Seeder;
    }

    @PostMapping("/<%= h.changeCase.kebab(seedName) %>")
    public ResponseEntity<String> run<%= seedName %>Seed() {
        try {
            <%= h.changeCase.camel(seedName) %>Seeder.seed();
            return ResponseEntity.ok("Seed completed successfully");
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body("Seed failed: " + e.getMessage());
        }
    }
}