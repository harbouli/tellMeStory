---
to: src/main/java/com/tellmestory/domain/<%= entity.toLowerCase() %>/<%= entity %>.java
inject: true
after: "import java.util.Objects;"
skip_if: <%= propertyType !== 'Relationship' %>
---
<% if (relationshipType === 'OneToMany' || relationshipType === 'ManyToMany') { -%>
import java.util.List;
<% } -%>
import com.tellmestory.domain.<%= relatedEntity.toLowerCase() %>.<%= relatedEntity %>;