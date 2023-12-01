import {readFileSync} from 'fs'

const input = readFileSync('./input.txt', { encoding: 'utf8', flag: 'r' })

let result = 0
input.split('\n').filter(line => line).forEach(line => {
    let firstNumber = undefined
    let lastNumber = undefined
    line.split('').forEach(char => {
        if (isNaN(char)) {
            return
        }

        if (firstNumber === undefined) {
            firstNumber = parseInt(char)
        }
        lastNumber = parseInt(char)
    })
    if (firstNumber !== undefined && lastNumber !== undefined) {
        result += firstNumber * 10 + lastNumber
    }
})

console.log(result)

