# Hygen Code Generation for TellMeStory

This project includes Hygen templates for rapid code generation following hexagonal architecture patterns.

## Available Generators

### 1. Add Property to Existing Entity

Adds a new property to an existing entity (User or Story) and updates all related files.

```bash
hygen property add
```

**What it generates:**
- Updates domain entity with new property
- Updates JPA entity with database mapping
- Updates entity constructors and getters
- Updates mappers for domain/entity conversion
- Handles validation and constraints

**Example Usage:**

*Adding a simple property:*
```bash
$ hygen property add
? Which entity to add property to? Story
? Property name (camelCase): rating
? Property type: BigDecimal
? Database column name (snake_case, leave empty for auto-generated): 
? Is this property nullable? No
? Should this property be unique? No
```

*Adding a relationship:*
```bash
$ hygen property add
? Which entity to add property to? Story
? Property name (camelCase): comments
? Property type: Relationship
? What type of relationship? OneToMany
? Related entity: Comment
? Is this a bidirectional relationship? Yes
? Mapped by property name (for bidirectional): story
? Fetch type for relationship: LAZY
? Cascade type: ALL
```

### 2. Generate New Module

Creates a complete new module with hexagonal architecture structure.

```bash
hygen module new
```

**What it generates:**
- Domain entity and ID classes
- Repository port and JPA implementation
- Service layer with use cases
- REST controller with DTOs
- Complete CRUD operations

**Example Usage:**
```bash
$ hygen module new
? Module name (PascalCase, e.g., Comment, Category): Comment
? Module description: Comments for stories
? Select features to include: 
  ◉ Domain entity
  ◉ Repository (JPA)
  ◉ Service layer
  ◉ REST Controller
  ◉ DTOs/Commands
```

## Generated Structure

When you generate a new module (e.g., "Comment"), it creates:

```
src/main/java/com/tellmestory/
├── domain/comment/
│   ├── Comment.java              # Domain entity
│   └── CommentId.java           # Value object for ID
├── application/
│   ├── ports/in/
│   │   ├── CreateCommentCommand.java
│   │   ├── CreateCommentUseCase.java
│   │   └── GetCommentsQuery.java
│   ├── ports/out/
│   │   └── CommentRepository.java
│   └── services/
│       └── CommentService.java
└── infrastructure/
    ├── adapters/in/web/
    │   ├── CommentController.java
    │   └── CommentResponse.java
    └── adapters/out/persistence/
        ├── CommentEntity.java
        ├── CommentJpaRepository.java
        ├── CommentRepositoryAdapter.java
        └── CommentMapper.java
```

## API Endpoints Generated

For each new module, the following REST endpoints are created:

- `POST /api/{module}s` - Create new entity
- `GET /api/{module}s` - Get all entities  
- `GET /api/{module}s/{id}` - Get entity by ID

## Features

### Property Generator Features:
- ✅ Supports all major Java types
- ✅ **Entity Relationships** (OneToOne, OneToMany, ManyToOne, ManyToMany)
- ✅ **Bidirectional relationships** with proper mapping
- ✅ **JPA annotations** (fetch types, cascade, join columns)
- ✅ Database constraints (nullable, unique, length)
- ✅ Automatic snake_case column naming
- ✅ Updates all related files consistently
- ✅ Maintains validation logic

### Module Generator Features:
- ✅ Complete hexagonal architecture setup
- ✅ Domain-driven design patterns
- ✅ JPA/Hibernate integration
- ✅ Spring Boot configuration
- ✅ RESTful API with validation
- ✅ Proper error handling

## Tips

1. **Property Names**: Use camelCase for property names (e.g., `firstName`, `createdDate`)
2. **Module Names**: Use PascalCase for module names (e.g., `Comment`, `Category`, `Tag`)
3. **Database Columns**: Leave column name empty to auto-generate snake_case names
4. **Validation**: The generator includes proper validation constraints
5. **Testing**: After generation, restart your application to register new components

## Customization

The templates are located in `_templates/` directory and can be customized:
- `_templates/property/add/` - Property addition templates
- `_templates/module/new/` - New module templates

Each template uses EJS syntax and supports all Hygen features including helpers and conditionals.