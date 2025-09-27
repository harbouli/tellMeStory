---
to: src/main/resources/application-<%= seedEnvironment %>.yml
inject: true
after: "app:"
---
  seed:
    enabled: <%= runOnStartup ? 'true' : 'false' %>
    <%= h.changeCase.camel(seedName) %>:
      enabled: true