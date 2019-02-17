PROGRAM ArraySort(input,output);

CONST MAX_LENGTH = 20;  //maximum number of integers in the array

TYPE
  tArr = ARRAY [1..MAX_LENGTH] OF integer;

VAR
  vArr : tArr;
  count : integer;

PROCEDURE printArray(VAR arr : tArr); //procedure to print array (pass by reference)
  VAR
    i : integer;
  BEGIN
    FOR i := 0 TO count - 1 DO  //for loop to iterate through the array
    write(arr[i], ' '); //print the integers in the array in one line
  END;

PROCEDURE sortArray(VAR arr : tArr);  //procedure to sort array (pass by reference)
  VAR
    i, j : integer;
    temp : integer;
  BEGIN //sort array in ascending order (swap technique)
    FOR i := 0 TO count - 1 DO BEGIN
      FOR j := i + 1 TO count - 1 DO BEGIN
        IF arr[i] > arr[j] THEN BEGIN
          temp := arr[i];
          arr[i] := arr[j];
          arr[j] := temp;
        END;
      END;
    END;
    writeln;  //line feed
    writeln;
    writeln('Sorted values: ');
  END;

BEGIN //ArraySort
  writeln;
  writeln('Original input values: ');
  count := 0;
  WHILE (NOT eoln) AND (count < MAX_LENGTH) DO  //reads the integers given in a line
    BEGIN
      read(vArr[count]);
      inc(count); //count = count + 1
    END;
  readln;
  printArray(vArr); //prints the original, unsorted input array
  sortArray(vArr);  //calls the procedure that sorts the array
  printArray(vArr); //prints the sorted array (ascending order)
END.
