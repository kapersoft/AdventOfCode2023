import {readFileSync} from 'fs'

const input = readFileSync('./input.txt', { encoding: 'utf8', flag: 'r' })

const numbers = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
}

const findNumberFn = (text) => {
    for (let number in numbers) {
        if (text.endsWith(number)) {
            return numbers[number]
        }
    }

    return undefined
}

let result = 0
input.split('\n').filter(line => line).forEach(line => {
    let firstNumber = undefined
    let lastNumber = undefined
    let text = ''
    line.split('').forEach(char => {
        if (isNaN(char)) {
            text += char
            let number = findNumberFn(text)
            if (number === undefined) {
                return;
            } else {
                char = number
            }
        }

        if (firstNumber === undefined) {
            firstNumber = parseInt(char)
        }
        lastNumber = parseInt(char)
    })

    if (firstNumber !== undefined && lastNumber !== undefined) {
        result += firstNumber * 10 + lastNumber
        console.log({firstNumber, lastNumber, number: firstNumber * 10 + lastNumber})
    }
})

console.log(result)

