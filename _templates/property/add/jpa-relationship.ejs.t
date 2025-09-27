---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "private LocalDateTime updatedAt;"
skip_if: <%= propertyType !== 'Relationship' %>
---

<% if (relationshipType === 'OneToOne') { -%>
    @OneToOne<% if (fetchType !== 'LAZY') { %>(fetch = FetchType.<%= fetchType %>)<% } %><% if (cascadeType !== 'NONE') { %>(cascade = CascadeType.<%= cascadeType %>)<% } %>
    <% if (joinColumnName) { -%>
@JoinColumn(name = "<%= joinColumnName %>")
    <% } -%>
private <%= relatedEntity %>Entity <%= propertyName %>;
<% } else if (relationshipType === 'ManyToOne') { -%>
    @ManyToOne<% if (fetchType !== 'LAZY') { %>(fetch = FetchType.<%= fetchType %>)<% } %><% if (cascadeType !== 'NONE') { %>(cascade = CascadeType.<%= cascadeType %>)<% } %>
    <% if (joinColumnName) { -%>
@JoinColumn(name = "<%= joinColumnName %>")
    <% } -%>
private <%= relatedEntity %>Entity <%= propertyName %>;
<% } else if (relationshipType === 'OneToMany') { -%>
    @OneToMany<% if (mappedBy) { %>(mappedBy = "<%= mappedBy %>")<% } %><% if (fetchType !== 'LAZY') { %>(fetch = FetchType.<%= fetchType %>)<% } %><% if (cascadeType !== 'NONE') { %>(cascade = CascadeType.<%= cascadeType %>)<% } %>
    private List<<%= relatedEntity %>Entity> <%= propertyName %>;
<% } else if (relationshipType === 'ManyToMany') { -%>
    @ManyToMany<% if (mappedBy) { %>(mappedBy = "<%= mappedBy %>")<% } %><% if (fetchType !== 'LAZY') { %>(fetch = FetchType.<%= fetchType %>)<% } %><% if (cascadeType !== 'NONE') { %>(cascade = CascadeType.<%= cascadeType %>)<% } %>
    <% if (joinTableName && !mappedBy) { -%>
@JoinTable(name = "<%= joinTableName %>")
    <% } -%>
private List<<%= relatedEntity %>Entity> <%= propertyName %>;
<% } -%>