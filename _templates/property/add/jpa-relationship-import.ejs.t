---
to: src/main/java/com/tellmestory/infrastructure/adapters/out/persistence/<%= entity %>Entity.java
inject: true
after: "import java.util.UUID;"
skip_if: <%= propertyType !== 'Relationship' %>
---
<% if (relationshipType === 'OneToMany' || relationshipType === 'ManyToMany') { -%>
import java.util.List;
<% } -%>
<% if (relationshipType === 'OneToOne') { -%>
import jakarta.persistence.OneToOne;
<% } else if (relationshipType === 'ManyToOne') { -%>
import jakarta.persistence.ManyToOne;
<% } else if (relationshipType === 'OneToMany') { -%>
import jakarta.persistence.OneToMany;
<% } else if (relationshipType === 'ManyToMany') { -%>
import jakarta.persistence.ManyToMany;
<% if (joinTableName && !mappedBy) { -%>
import jakarta.persistence.JoinTable;
<% } -%>
<% } -%>
<% if (joinColumnName) { -%>
import jakarta.persistence.JoinColumn;
<% } -%>
<% if (fetchType !== 'LAZY') { -%>
import jakarta.persistence.FetchType;
<% } -%>
<% if (cascadeType !== 'NONE') { -%>
import jakarta.persistence.CascadeType;
<% } -%>