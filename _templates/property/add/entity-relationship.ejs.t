---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "private final LocalDateTime updatedAt;"
skip_if: <%= propertyType !== 'Relationship' %>
---
<% if (relationshipDescription) { -%>
    // <%= relationshipDescription %>
<% } -%>
<% if (relationshipType === 'OneToMany' || relationshipType === 'ManyToMany') { -%>
    private final List<<%= relatedEntity %>> <%= propertyName %>;
<% } else { -%>
    private final <%= relatedEntity %> <%= propertyName %>;
<% } -%>