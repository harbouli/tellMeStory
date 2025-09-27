---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "public LocalDateTime getUpdatedAt() { return updatedAt; }"
skip_if: <%= propertyType !== 'Relationship' %>
---
<% if (relationshipType === 'OneToMany' || relationshipType === 'ManyToMany') { -%>
    public List<<%= relatedEntity %>> get<%= h.changeCase.pascal(propertyName) %>() { return <%= propertyName %>; }
<% } else { -%>
    public <%= relatedEntity %> get<%= h.changeCase.pascal(propertyName) %>() { return <%= propertyName %>; }
<% } -%>