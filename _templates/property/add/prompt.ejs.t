---
to: _prompts
---
[
  {
    type: 'select',
    name: 'entity',
    message: 'Which entity to add property to?',
    choices: ['User', 'Story']
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
    choices: ['String', 'Integer', 'Long', 'Boolean', 'LocalDateTime', 'BigDecimal']
  },
  {
    type: 'input',
    name: 'columnName',
    message: 'Database column name (snake_case, leave empty for auto-generated):'
  },
  {
    type: 'confirm',
    name: 'nullable',
    message: 'Is this property nullable?',
    initial: false
  },
  {
    type: 'confirm',
    name: 'unique',
    message: 'Should this property be unique?',
    initial: false
  },
  {
    type: 'input',
    name: 'length',
    message: 'Max length (for String types, leave empty for default):',
    skip: () => !['String'].includes(prompt.propertyType)
  }
]