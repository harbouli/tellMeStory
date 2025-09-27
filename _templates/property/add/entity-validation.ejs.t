---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "this.updatedAt = Objects.requireNonNull(updatedAt, \"Updated at cannot be null\");"
---
        this.<%= propertyName %> = <% if (!nullable) { %>Objects.requireNonNull(<%= propertyName %>, "<%= entity %> <%= propertyName %> cannot be null")<% } else { %><%= propertyName %><% } %>;