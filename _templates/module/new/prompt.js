module.exports = [
  {
    type: 'input',
    name: 'moduleName',
    message: 'Module name (PascalCase, e.g., Comment, Category):',
    validate: (input) => input.length > 0 ? true : 'Module name is required'
  },
  {
    type: 'input',
    name: 'moduleDescription',
    message: 'Module description:',
    initial: 'New module for the application'
  },
  {
    type: 'multiselect',
    name: 'features',
    message: 'Select features to include:',
    choices: [
      { name: 'domain', message: 'Domain entity', initial: true },
      { name: 'repository', message: 'Repository (JPA)', initial: true },
      { name: 'service', message: 'Service layer', initial: true },
      { name: 'controller', message: 'REST Controller', initial: true },
      { name: 'dto', message: 'DTOs/Commands', initial: true }
    ]
  }
]