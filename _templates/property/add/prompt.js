const fs = require('fs');
const path = require('path');

// Get relationship suggestions based on common patterns
function getRelationshipSuggestions(entity, relatedEntity, relationshipType) {
  const commonRoles = {
    'User': {
      'Story': ['author', 'creator', 'writer'],
      'Comment': ['author', 'commenter'],
      'Category': ['creator', 'owner'],
      'Profile': ['owner'],
      'Tag': ['creator']
    },
    'Story': {
      'User': ['author', 'creator'],
      'Comment': ['target', 'parent'],
      'Category': ['category', 'classification'],
      'Tag': ['tags']
    },
    'Comment': {
      'User': ['author'],
      'Story': ['story', 'target'],
      'Comment': ['parent', 'reply_to']
    },
    'Category': {
      'Story': ['stories'],
      'User': ['creator']
    }
  };

  const suggestions = commonRoles[entity]?.[relatedEntity] || 
                     commonRoles[relatedEntity]?.[entity] || 
                     ['related', 'associated', 'linked'];
  
  return [...suggestions, 'custom'];
}

// Get relationship description text
function getRelationshipText(relationshipType) {
  const texts = {
    'OneToOne': 'has one',
    'OneToMany': 'has many',
    'ManyToOne': 'belongs to',
    'ManyToMany': 'has many'
  };
  return texts[relationshipType] || 'relates to';
}

// Dynamically find all domain entities
function getAvailableEntities() {
  const domainPath = path.join(process.cwd(), 'src/main/java/com/tellmestory/domain');
  
  if (!fs.existsSync(domainPath)) {
    return ['User', 'Story']; // fallback
  }
  
  const entities = [];
  const directories = fs.readdirSync(domainPath, { withFileTypes: true });
  
  for (const dir of directories) {
    if (dir.isDirectory()) {
      const entityPath = path.join(domainPath, dir.name);
      const files = fs.readdirSync(entityPath);
      
      // Look for the main entity file (not the Id file)
      const entityFile = files.find(file => 
        file.endsWith('.java') && 
        !file.endsWith('Id.java') &&
        file.charAt(0) === file.charAt(0).toUpperCase()
      );
      
      if (entityFile) {
        const entityName = entityFile.replace('.java', '');
        entities.push(entityName);
      }
    }
  }
  
  return entities.length > 0 ? entities : ['User', 'Story'];
}

module.exports = [
  {
    type: 'select',
    name: 'entity',
    message: 'Which entity to add property to?',
    choices: getAvailableEntities()
  },
  {
    type: 'input',
    name: 'propertyName',
    message: 'Property name (camelCase):'
  },
  {
    type: 'select',
    name: 'propertyType',
    message: 'Property type:',
    choices: ['String', 'Integer', 'Long', 'Boolean', 'LocalDateTime', 'BigDecimal', 'Relationship']
  },
  {
    type: 'select',
    name: 'relationshipType',
    message: (answers) => {
      try {
        const entity = (answers && answers.entity) || 'this entity';
        return `What type of relationship between ${entity} and the related entity?`;
      } catch (error) {
        return 'What type of relationship?';
      }
    },
    choices: [
      { name: 'OneToOne', message: 'OneToOne (1:1) - Each record relates to exactly one other record' },
      { name: 'OneToMany', message: 'OneToMany (1:N) - One record relates to many others' },
      { name: 'ManyToOne', message: 'ManyToOne (N:1) - Many records relate to one other' },
      { name: 'ManyToMany', message: 'ManyToMany (N:N) - Many records relate to many others' }
    ],
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'select',
    name: 'relatedEntity',
    message: 'Related entity:',
    choices: (answers) => {
      try {
        const entities = getAvailableEntities();
        if (!answers || !answers.entity) {
          return entities; // Return all entities if answers or entity is not available
        }
        return entities.filter(entity => entity !== answers.entity);
      } catch (error) {
        console.log('Error in relatedEntity choices:', error);
        return getAvailableEntities(); // Fallback to all entities
      }
    },
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'select',
    name: 'relationshipRole',
    message: (answers) => {
      try {
        const entity = (answers && answers.entity) || 'Entity';
        const relatedEntity = (answers && answers.relatedEntity) || 'RelatedEntity';
        return `What role does ${relatedEntity} play in relation to ${entity}?`;
      } catch (error) {
        return 'What role does the related entity play?';
      }
    },
    choices: (answers) => {
      try {
        const entity = (answers && answers.entity) || '';
        const relatedEntity = (answers && answers.relatedEntity) || '';
        const relationshipType = (answers && answers.relationshipType) || '';
        const suggestions = getRelationshipSuggestions(entity, relatedEntity, relationshipType);
        return suggestions;
      } catch (error) {
        console.log('Error in relationshipRole choices:', error);
        return ['author', 'owner', 'creator', 'custom']; // Fallback suggestions
      }
    },
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'input',
    name: 'relationshipDescription',
    message: (answers) => {
      try {
        const entity = (answers && answers.entity) || 'Entity';
        const relatedEntity = (answers && answers.relatedEntity) || 'RelatedEntity';
        const relationshipType = (answers && answers.relationshipType) || 'relates to';
        const roleText = (answers && answers.relationshipRole) || 'custom role';
        const relationshipText = getRelationshipText(relationshipType);
        return `Custom description (or press Enter to use: "${entity} ${relationshipText} ${relatedEntity} as ${roleText}"):`;
      } catch (error) {
        return 'Custom description for this relationship:';
      }
    },
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'confirm',
    name: 'bidirectional',
    message: 'Is this a bidirectional relationship?',
    initial: false,
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'input',
    name: 'mappedBy',
    message: 'Mapped by property name (for bidirectional):',
    when: (answers) => answers && answers.propertyType === 'Relationship' && answers.bidirectional
  },
  {
    type: 'input',
    name: 'columnName',
    message: 'Database column name (snake_case, leave empty for auto-generated):',
    when: (answers) => answers.propertyType !== 'Relationship'
  },
  {
    type: 'input',
    name: 'joinColumnName',
    message: 'Join column name (for foreign key, leave empty for auto-generated):',
    when: (answers) => answers && answers.propertyType === 'Relationship' && ['OneToOne', 'ManyToOne'].includes(answers.relationshipType)
  },
  {
    type: 'input',
    name: 'joinTableName',
    message: 'Join table name (for ManyToMany, leave empty for auto-generated):',
    when: (answers) => answers && answers.propertyType === 'Relationship' && answers.relationshipType === 'ManyToMany'
  },
  {
    type: 'confirm',
    name: 'nullable',
    message: 'Is this property nullable?',
    initial: false,
    when: (answers) => answers.propertyType !== 'Relationship'
  },
  {
    type: 'confirm',
    name: 'unique',
    message: 'Should this property be unique?',
    initial: false,
    when: (answers) => answers.propertyType !== 'Relationship'
  },
  {
    type: 'input',
    name: 'length',
    message: 'Max length (for String types, leave empty for default):',
    when: (answers) => answers.propertyType === 'String'
  },
  {
    type: 'select',
    name: 'fetchType',
    message: 'Fetch type for relationship:',
    choices: ['LAZY', 'EAGER'],
    initial: 'LAZY',
    when: (answers) => answers && answers.propertyType === 'Relationship'
  },
  {
    type: 'select',
    name: 'cascadeType',
    message: 'Cascade type:',
    choices: ['NONE', 'ALL', 'PERSIST', 'MERGE', 'REMOVE', 'REFRESH', 'DETACH'],
    initial: 'NONE',
    when: (answers) => answers && answers.propertyType === 'Relationship'
  }
]