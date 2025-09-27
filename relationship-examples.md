# Relationship Examples with Hygen

## Common Relationship Patterns

### 1. Story has many Comments (OneToMany)

```bash
# Add comments to Story
hygen property add
? Which entity to add property to? Story
? Property name (camelCase): comments
? Property type: Relationship
? What type of relationship? OneToMany
? Related entity: Comment
? Is this a bidirectional relationship? Yes
? Mapped by property name (for bidirectional): story
? Fetch type for relationship: LAZY
? Cascade type: ALL

# Add story reference to Comment
hygen property add
? Which entity to add property to? Comment
? Property name (camelCase): story
? Property type: Relationship
? What type of relationship? ManyToOne
? Related entity: Story
? Is this a bidirectional relationship? No
? Join column name (for foreign key, leave empty for auto-generated): story_id
? Fetch type for relationship: LAZY
? Cascade type: NONE
```

### 2. User has one Profile (OneToOne)

```bash
# Create Profile module first
hygen module new
? Module name: Profile
? Module description: User profiles
? Select all features

# Add profile to User
hygen property add
? Which entity to add property to? User
? Property name (camelCase): profile
? Property type: Relationship
? What type of relationship? OneToOne
? Related entity: Profile
? Is this a bidirectional relationship? Yes
? Mapped by property name (for bidirectional): user
? Fetch type for relationship: LAZY
? Cascade type: ALL

# Add user reference to Profile
hygen property add
? Which entity to add property to? Profile
? Property name (camelCase): user
? Property type: Relationship
? What type of relationship? OneToOne
? Related entity: User
? Is this a bidirectional relationship? No
? Join column name (for foreign key, leave empty for auto-generated): user_id
? Fetch type for relationship: LAZY
? Cascade type: NONE
```

### 3. Story belongs to many Categories (ManyToMany)

```bash
# Create Category module first
hygen module new
? Module name: Category
? Module description: Story categories
? Select all features

# Add categories to Story
hygen property add
? Which entity to add property to? Story
? Property name (camelCase): categories
? Property type: Relationship
? What type of relationship? ManyToMany
? Related entity: Category
? Is this a bidirectional relationship? Yes
? Mapped by property name (for bidirectional): stories
? Fetch type for relationship: LAZY
? Cascade type: NONE

# Add stories to Category
hygen property add
? Which entity to add property to? Category
? Property name (camelCase): stories
? Property type: Relationship
? What type of relationship? ManyToMany
? Related entity: Story
? Is this a bidirectional relationship? No
? Join table name (for ManyToMany, leave empty for auto-generated): story_categories
? Fetch type for relationship: LAZY
? Cascade type: NONE
```

### 4. User has many Stories (OneToMany) - Author relationship

```bash
# Add author relationship to Story
hygen property add
? Which entity to add property to? Story
? Property name (camelCase): author
? Property type: Relationship
? What type of relationship? ManyToOne
? Related entity: User
? Is this a bidirectional relationship? Yes
? Join column name (for foreign key, leave empty for auto-generated): author_id
? Fetch type for relationship: LAZY
? Cascade type: NONE

# Add stories to User
hygen property add
? Which entity to add property to? User
? Property name (camelCase): stories
? Property type: Relationship
? What type of relationship? OneToMany
? Related entity: Story
? Is this a bidirectional relationship? No
? Mapped by property name (for bidirectional): author
? Fetch type for relationship: LAZY
? Cascade type: NONE
```

## Generated Code Examples

### OneToMany Relationship (Story -> Comments)

**Domain Entity (Story.java):**
```java
private final List<Comment> comments;

public List<Comment> getComments() { return comments; }
```

**JPA Entity (StoryEntity.java):**
```java
@OneToMany(mappedBy = "story", cascade = CascadeType.ALL)
private List<CommentEntity> comments;
```

### ManyToOne Relationship (Comment -> Story)

**Domain Entity (Comment.java):**
```java
private final Story story;

public Story getStory() { return story; }
```

**JPA Entity (CommentEntity.java):**
```java
@ManyToOne
@JoinColumn(name = "story_id")
private StoryEntity story;
```

### ManyToMany Relationship (Story <-> Categories)

**JPA Entity (StoryEntity.java):**
```java
@ManyToMany
@JoinTable(name = "story_categories")
private List<CategoryEntity> categories;
```

**JPA Entity (CategoryEntity.java):**
```java
@ManyToMany(mappedBy = "categories")
private List<StoryEntity> stories;
```

## Best Practices

1. **Lazy Loading**: Use `LAZY` fetch type by default for performance
2. **Cascade Types**: 
   - Use `ALL` for owned relationships (parent-child)
   - Use `NONE` or specific types for associations
3. **Bidirectional**: 
   - Define the owning side (without `mappedBy`)
   - Use `mappedBy` on the inverse side
4. **Join Columns**: Let Hibernate generate names or use meaningful names
5. **Collections**: Use `List<>` for ordered collections, `Set<>` for unique collections