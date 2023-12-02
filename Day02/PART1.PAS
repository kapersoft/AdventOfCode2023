program Day02;
uses crt;

const
  red = 0;
  blue = 1;
  green = 2;
  maxGames = 128;
  maxDraws = 64;

var
  game: array[0..maxGames, 0..maxDraws, 0..2] of integer;
  result: integer;

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

function calculateResult(redCubes, greenCubes, blueCubes: integer): integer;
var
  gameTotal: integer;
  gameNumber: integer;
  drawNumber: integer;
  redDraws: integer;
  blueDraws: integer;
  greenDraws: integer;
  validGame: boolean;
begin
  gameTotal := 0;

  for gameNumber := 0 to maxGames do
  begin
    validGame := false;

    for drawNumber := 0 to maxDraws do
    begin
      redDraws := game[gameNumber][drawNumber][red];
      blueDraws := game[gameNumber][drawNumber][blue];
      greenDraws := game[gameNumber][drawNumber][green];

      if ((redDraws + blueDraws + greenDraws) = 0) then
        continue;

      if ((redDraws > redCubes) or (blueDraws > blueCubes) or (greenDraws > greenCubes)) then
      begin
        validGame := false;
        break;
      end;

      validGame := true;
    end;

    if (validGame) then
    begin
      debugNumber('Valid gameNumber', gameNumber + 1);
      gameTotal := gameTotal + gameNumber + 1;
    end;

  end;

  calculateResult := gameTotal;
end;

begin
  readInput;
  result := calculateResult(12, 13, 14);
  writeLn(result);
end.
