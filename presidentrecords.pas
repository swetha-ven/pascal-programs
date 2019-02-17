PROGRAM PresidentRecords(input,output);

CONST
  MAX_PRESIDENTS = 20;
  MAX_NAME_LENGTH = 10;
  FIELD_SEPARATOR = ' ';
  
TYPE
  nameString = PACKED ARRAY [1..MAX_NAME_LENGTH] OF char;
  codeChar = 'A'..'Z';
  codeSet = SET OF codeChar;
  
  presidentRec = RECORD
                    id : integer;
                    lastName : nameString;
                    firstName : nameString;
                END;

VAR
  presidentCount : integer;
  presidents : ARRAY [1..MAX_PRESIDENTS] OF presidentRec;

//Read the president ID and return its integer value
FUNCTION readId : integer;
  VAR
    id : integer;
    ch : char;
  BEGIN
    id := 0;
    //Read the ID digits until the field separator
    REPEAT
      read(ch); //ID digit
      //Compute the integer value
      if(ch <> FIELD_SEPARATOR) THEN BEGIN
        id := 10*id + (ord(ch) - ord('0'));
      END;
    UNTIL ch = FIELD_SEPARATOR;
    readId := id;
  END;

//Read a first or last name and return it by reference
PROCEDURE readName(VAR name : nameString);
  VAR
    i : integer;
    ch : char;
  BEGIN
    i := 0;
    name := ' ';  //Initialize to all blanks
    //Loop to read name characters until the field separator or the end of the line or MAX_NAME_LENGTH characters have been read
    REPEAT
      IF NOT eoln THEN BEGIN
        read(ch); //name character
        IF (ch <> FIELD_SEPARATOR) AND (i <= MAX_NAME_LENGTH) THEN BEGIN
          i := i + 1;
          name[i] := ch;
        END;
      END;
    UNTIL eoln OR (ch = FIELD_SEPARATOR) OR (i = MAX_NAME_LENGTH);
    //Read the rest of the name if more than MAX_NAME_LENGTH characters
    IF i = MAX_NAME_LENGTH THEN BEGIN
      WHILE (NOT eoln) AND (ch <> FIELD_SEPARATOR) DO BEGIN
        read(ch);
      END;
    END;
  END;
  
//Read the president records
PROCEDURE readPresidents;
  VAR
    i : integer;
  BEGIN
    i := 0;
    //Read to the end of file or until MAX_PRESIDENTS have been read
    WHILE (NOT eof) AND (i < MAX_PRESIDENTS) DO BEGIN
      i := i + 1;
      WITH presidents[i] DO BEGIN
        id := readID;
        readName(lastName);
        readName(firstName);
        readln;
      END;
    END;
    presidentCount := i - 1;
  END;
  
//Print the president records
PROCEDURE printPresidents;
  VAR
    i : integer;
  BEGIN
    FOR i := 1 TO presidentCount DO BEGIN
      writeln;
      WITH presidents[i] DO BEGIN
        writeln('        Id: ', id);
        writeln(' Last name: ', lastName);
        writeln('First name: ', firstName);
      END;
    END;
    
    writeln;
    writeln(presidentCount : 1, 'presidents read.');
  END;
  
//Check for extra records
PROCEDURE checkForExtras
  VAR
    extra : PACKED ARRAY [1..80] OF char;
  BEGIN
    IF NOT eof THEN BEGIN
      writeln;
      writeln('WARNING: Unprocessed records:');
      writeln;
      WHILE NOT eof DO BEGIN
        extra := ' ';
        readln(extra);
        writeln('     ', extra);
      END;
    END;
  END;

BEGIN //PresidentRecords
  readPresidents;
  printPresidents;
  checkForExtras;
END.  
