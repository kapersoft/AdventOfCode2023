import fs from 'fs'

function readInput() {
    const input = fs.readFileSync('./input.txt', { encoding: 'utf8', flag: 'r' })
    return input.split('\n').filter(line => line).map(line => {
        const fnExtractNumbers = numbers => numbers.split(' ').map(number => parseInt(number)).filter(number => !isNaN(number))

        const id = parseInt(line.split('Card ')[1].split(':')[0]);

        let [winningNumbers, havingNumbers] = line.split(': ')[1].split('|')
        winningNumbers = fnExtractNumbers(winningNumbers)
        havingNumbers = fnExtractNumbers(havingNumbers)
        const cardScore = winningNumbers.filter(winningNumber => havingNumbers.includes(winningNumber)).length || 0

        return {id, cardScore}
    }, {})
}

const cardScores = readInput()

const countedCards = [...cardScores]

for (let i = 0; i < countedCards.length; i++) {
    for (let j = 0; j < countedCards[i].cardScore; j++) {
        countedCards.push(cardScores[countedCards[i].id + j])
    }
}

console.log(countedCards.length)
