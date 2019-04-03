const teaDBBeforeThursday:{[teaName:string]:string} = {
  'green tea': 'unfermented whole leaf tea'
}

interface teaObject {
  teaName:string
  description:string
  brewingStyle:string
  lastChanged?:string // May or may not be included
}
const teaDBSinceThursday:{[teaName:string]:teaObject} = {
  'green tea': {
    teaName: 'green tea',
    description: 'unfermented whole leaf tea',
    brewingStyle: 'Kong Fu Tea',
  }
  
}