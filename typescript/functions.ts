function square(n:number):number {
  const output = n * n
  return output
}

// square('Jiaxing') // Stopped through types!

// Making your own types 
type NumberFn = (n:Number) => Number
const numberFn:NumberFn = square 

