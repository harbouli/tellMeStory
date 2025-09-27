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
    type: 'input',
    name: 'seedName',
    message: 'Seed name (e.g., InitialUsers, SampleStories):',
    validate: (input) => input.length > 0 ? true : 'Seed name is required'
  },
  {
    type: 'input',
    name: 'seedDescription',
    message: 'Seed description:',
    initial: 'Initial data seeding'
  },
  {
    type: 'multiselect',
    name: 'entities',
    message: 'Select entities to seed:',
    choices: getAvailableEntities().map(entity => ({
      name: entity,
      message: `${entity} entities`,
      initial: false
    }))
  },
  {
    type: 'input',
    name: 'userCount',
    message: 'Number of users to create:',
    initial: '10',
    when: (answers) => answers.entities.includes('User')
  },
  {
    type: 'input',
    name: 'storyCount',
    message: 'Number of stories to create:',
    initial: '20',
    when: (answers) => answers.entities.includes('Story')
  },
  {
    type: 'input',
    name: 'commentCount',
    message: 'Number of comments to create:',
    initial: '50',
    when: (answers) => answers.entities.includes('Comment')
  },
  {
    type: 'confirm',
    name: 'runOnStartup',
    message: 'Run this seed automatically on application startup?',
    initial: false
  },
  {
    type: 'select',
    name: 'seedEnvironment',
    message: 'Run seed in which environments?',
    choices: ['development', 'test', 'all'],
    initial: 'development'
  }
]