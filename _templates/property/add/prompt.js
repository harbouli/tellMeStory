const fs = require('fs');
const path = require('path');

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
    message: 'What type of relationship?',
    choices: ['OneToOne', 'OneToMany', 'ManyToOne', 'ManyToMany'],
    when: (answers) => answers.propertyType === 'Relationship'
  },
  {
    type: 'select',
    name: 'relatedEntity',
    message: 'Related entity:',
    choices: (answers) => getAvailableEntities().filter(entity => entity !== answers.entity),
    when: (answers) => answers.propertyType === 'Relationship'
  },
  {
    type: 'confirm',
    name: 'bidirectional',
    message: 'Is this a bidirectional relationship?',
    initial: false,
    when: (answers) => answers.propertyType === 'Relationship'
  },
  {
    type: 'input',
    name: 'mappedBy',
    message: 'Mapped by property name (for bidirectional):',
    when: (answers) => answers.propertyType === 'Relationship' && answers.bidirectional
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
    when: (answers) => answers.propertyType === 'Relationship' && ['OneToOne', 'ManyToOne'].includes(answers.relationshipType)
  },
  {
    type: 'input',
    name: 'joinTableName',
    message: 'Join table name (for ManyToMany, leave empty for auto-generated):',
    when: (answers) => answers.propertyType === 'Relationship' && answers.relationshipType === 'ManyToMany'
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
    when: (answers) => answers.propertyType === 'Relationship'
  },
  {
    type: 'select',
    name: 'cascadeType',
    message: 'Cascade type:',
    choices: ['NONE', 'ALL', 'PERSIST', 'MERGE', 'REMOVE', 'REFRESH', 'DETACH'],
    initial: 'NONE',
    when: (answers) => answers.propertyType === 'Relationship'
  }
]