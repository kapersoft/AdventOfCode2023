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
    $number = '';

    foreach ($schematic as $rowNr => $row) {
        $number = '';
        foreach ($row as $colNr => $cell) {
            if (!is_numeric($cell)) {
                continue;
            };

            $number .= $cell;

            $nextCell = $schematic[$rowNr][$colNr + 1] ?? '.';
            if (is_numeric($nextCell)) {
                continue;
            }

            if (
                $number !== '' &&
                isAdjacentToSymbol($schematic, $rowNr, $colNr - strlen($number) + 1, strlen($number))
            ) {
                $result += (int)$number;
            }

            $number = '';
        }
    }

    return $result;
}

function isAdjacentToSymbol(array $schematic, int $rowNr, int $colNr, int $length) {
    $rowStart = max($rowNr - 1, 0);
    $rowEnd = min($rowNr + 1, count($schematic) - 1);
    $colStart = max($colNr - 1, 0);
    $colEnd = min($colStart + $length + 1, count($schematic[$rowNr]) - 1);
    $rowRange = range($rowStart, $rowEnd);
    $colRange = range($colStart, $colEnd);

    foreach ($rowRange as $rowRangNr) {
        foreach ($colRange as $colRangNr) {
            $cell = $schematic[$rowRangNr][$colRangNr] ?? '.';
            if (!is_numeric($cell) && $cell !== '.') {
                return true;
            }

        }
    }
    return false;
}

$schematic = readInput();

$result = calculate($schematic);

var_dump($result);
