<?php

function readInput(): array
{
    $input = file_get_contents('input.txt');
    return array_map(
        fn (string $row) => str_split($row),
        array_filter(explode("\n", $input))
    );
}

function calculate(array $schematic): int
{
    $result = 0;

    foreach ($schematic as $rowNr => $row) {
        foreach ($row as $colNr => $cell) {
            if ($cell !== '*') {
                continue;
            };

            $partNumbers = findPartNumbers($schematic, $rowNr, $colNr);
            if (count($partNumbers) === 2) {
                $result += $partNumbers[0] * $partNumbers[1];
            }
        }
    }

    return $result;
}

function findPartNumbers(array $schematic, int $rowNr, int $colNr): array
{
    $result = [];
    $rowStart = max($rowNr - 1, 0);
    $rowEnd = min($rowNr + 1, count($schematic) - 1);
    $colStart = max($colNr - 1, 0);
    $colEnd = min($colStart + 2, count($schematic[$rowNr]) - 1);
    $rowRange = range($rowStart, $rowEnd);
    $colRange = range($colStart, $colEnd);

    foreach ($rowRange as $rowRangNr) {
        foreach ($colRange as $colRangNr) {
            $cell = $schematic[$rowRangNr][$colRangNr] ?? '.';
            if (is_numeric($cell)) {
                $result[] = findPartNumber($schematic, $rowRangNr, $colRangNr);
            }
        }
    }

    return $result;
}

function findPartNumber(array &$schematic, int $rowNr, int $colNr): int {
    $number = $schematic[$rowNr][$colNr];
    $schematic[$rowNr][$colNr] = 'X';

    $checkColNr = $colNr;
    while (true) {
        $checkColNr--;
        $cell = $schematic[$rowNr][$checkColNr] ?? '.';
        if (!is_numeric($cell)) {
            break;
        }
        $number = $cell . $number;
        $schematic[$rowNr][$checkColNr] = 'X';
    }

    $checkColNr = $colNr;
    while (true) {
        $checkColNr++;
        $cell = $schematic[$rowNr][$checkColNr] ?? '.';
        if (!is_numeric($cell)) {
            break;
        }
        $number = $number . $cell;
        $schematic[$rowNr][$checkColNr] = 'X';
    }

    return (int)$number;
}

$schematic = readInput();

$result = calculate($schematic);
