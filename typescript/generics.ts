function areAllStrings(items:string[], tester:(item:string) => boolean):boolean {
  for (const item of items) {
    if (!tester(item)) {
      return false
    }
  }
  return true
}

const allStrings = ['hey', 'ha']
const allStringsAreShort = areAllStrings(allStrings, (s) => s.length < 4)