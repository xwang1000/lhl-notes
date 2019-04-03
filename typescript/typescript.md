# TypeScript
*W9D3*

- code is more legible
- compiler catch a whole class of errors early
  - syntax / semantic errors

- Superset language of JavaScript with optional static typing: TypeScript, Sass


## Common Types
- any (catch all)
- boolean, number, string
- undefined
- string[] (array of strings)
- object(cathcces objects, arrays and null)
- Date
- `{[id:string]:boolean}` (object with string keys and boolean values)

## Interfaces (AKA Contracts)

Defines the shapes of data objects

``` TypeScript
  interface Student {

  }
```

## Classes

TypeScript classes are just JS classes with some bells and whistles, including:

- private and public members 
- abstract classes 


## Generics 

generics let you generate functions, interfaces...