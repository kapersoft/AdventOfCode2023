program Day02_Part2;

uses crt;

const
  red = 0;
  blue = 1;
  green = 2;
  maxGames = 128;
  maxDraws = 64;

var
  game: array[0..maxGames, 0..maxDraws, 0..2] of shortint;
  result: real;

function stringBefore(content, before: string): string;
var
  position: integer;
begin
  stringBefore := content;
  position := pos(before, content);
  if (position > 0) then
    stringBefore := copy(content, 0, position - 1);
end;

function stringAfter(content, after: string): string;
var
  position: integer;
  lengthContent: integer;
  lengthAfter: integer;
begin
  stringAfter := '';
  position := pos(after, content);
  if (position > 0) then
  begin
    lengthContent := length(content);
    lengthAfter := length(after);
    stringAfter := copy(content, position + lengthAfter, lengthContent - position);
  end;
end;

function stringBetween(content, first, second: string): string;
begin
  stringBetween := stringBefore(stringAfter(content, first), second);
end;

function toInt(data: string): integer;
var
  output: integer;
  conversion: integer;
begin
  val(data, output, conversion);
  toInt := output;
end;

procedure debugText(info, text: string);
begin
  writeLn(concat(info, ': "', text, '"'));
end;

procedure debugNumber(info: string; number: integer);
var
  numberText: string;
begin
  str(number, numberText);
  debugText(info, numberText);
end;

procedure readInput;
var
  gameText: string;
  f: text;
  gameNr: integer;
  drawNr: integer;
  drawText: string;
  colorAmountText: string;
  colorText: string;
  amount: integer;
begin
  assign(f, 'input.txt');
  reset(f);
  while not eof(f) do
  begin
    drawNr := 0;
    readln(f, gameText);
    gameNr :=toInt(stringBetween(gameText, 'Game ', ':')) - 1;
    gameText := stringAfter(gameText, ': ');

    repeat
      drawText := stringBefore(gameText, ';');

      game[gameNr][drawNr][red] := 0;
      game[gameNr][drawNr][blue] := 0;
      game[gameNr][drawNr][green] := 0;

      repeat
        colorAmountText := stringBefore(drawText, ', ');
        amount := toInt(stringBefore(colorAmountText, ' '));
        colorText := stringAfter(colorAmountText, ' ');

        case (colorText[1]) of
            'r': game[gameNr][drawNr][red] := amount;
            'b': game[gameNr][drawNr][blue] := amount;
            'g': game[gameNr][drawNr][green] := amount;
        end;

        drawText := stringAfter(drawText, ', ');
      until length(drawText) = 0;

      gameText := stringAfter(gameText, '; ');
      drawNr := drawNr + 1;

    until length(gameText) = 0;

  end;
  close(f);
end;

function calculateResult: real;
var
  gameTotal: real;
  gameNumber: integer;
  drawNumber: integer;
  redDraws: integer;
  blueDraws: integer;
  greenDraws: integer;
  maxGreen: integer;
  maxRed: integer;
  maxBlue: integer;
  power: integer;
begin
  gameTotal := 0;

  for gameNumber := 0 to maxGames do
  begin
    maxGreen := 0;
    maxRed := 0;
    maxBlue := 0;

    for drawNumber := 0 to maxDraws do
    begin
      redDraws := game[gameNumber][drawNumber][red];
      blueDraws := game[gameNumber][drawNumber][blue];
      greenDraws := game[gameNumber][drawNumber][green];

      if ((redDraws + blueDraws + greenDraws) = 0) then
        continue;

      if (redDraws > maxRed) then
        maxRed := redDraws;
      if (blueDraws > maxBlue) then
        maxBlue := blueDraws;
      if (greenDraws > maxGreen) then
        maxGreen := greenDraws;
    end;

    if ((maxRed + maxBlue + maxGreen) = 0) then
      continue;

    power := maxRed * maxBlue * maxGreen;
    gameTotal := gameTotal + power;
  end;

  calculateResult := gameTotal;
end;

begin
  readInput;
  result := calculateResult;
  writeLn(result);
end.
