import fs from 'fs'

function readInput() {
    const input = fs.readFileSync('./input.txt', { encoding: 'utf8', flag: 'r' })
    return input.split('\n').filter(line => line).map(line => {

        let [winningNumbers, havingNumbers] = line.split(': ')[1].split('|')
        const fnExtractNumbers = numbers => numbers.split(' ').map(number => parseInt(number)).filter(number => !isNaN(number))

        return {
            id: parseInt(line.split('Card ')[1].split(':')[0]),
            winningNumbers: fnExtractNumbers(winningNumbers),
            havingNumbers: fnExtractNumbers(havingNumbers),
        }
    })
}

const score = readInput().reduce((totalScore, card) => {
    return totalScore + card.winningNumbers.reduce((cardScore, winningNumber) => {
        if (card.havingNumbers.includes(winningNumber)) {
            return cardScore === 0 ? 1 : cardScore * 2
        }
        return cardScore
    }, 0)
}, 0)

console.log(score)
