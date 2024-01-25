REM SUB DECLARATIONS
DECLARE SUB DISPLAY ()
DECLARE SUB CENTER (ROW, text$)
DECLARE SUB BLOCK ()
DECLARE SUB ENEMY ()

REM GAME SEQUENCE
DIM SHARED RANDOMX AS INTEGER, RANDOMY AS INTEGER
DIM SHARED SCORE AS INTEGER
DISPLAY
ENEMY
BLOCK
END

SUB BLOCK
x = 320
y = 240
DIM nx(21), ny(21)
STARTTIME = TIMER

REM Loop with game logic for blocks for 30 secs
DO WHILE TIMER - STARTTIME < 31

Key$ = INKEY$
REM Clear the previous position of the block
LINE (x, y)-(x + 20, y + 20), 0, BF
LOCATE 28, 1
PRINT "SCORE:", SCORE
LOCATE 28, 40
ELAPSED = INT(TIMER - STARTTIME)
PRINT "TIMER:", 30 - ELAPSED

REM Check for conditions
IF y > 400 THEN
y = 0
END IF
IF y < 0 THEN
y = 400
END IF
IF x > 640 THEN
x = 0
END IF
IF x < 0 THEN
x = 640
END IF
SELECT CASE UCASE$(Key$)
CASE CHR$(0) + CHR$(77)
x = x + 5
CASE CHR$(0) + CHR$(75)
x = x - 5
CASE CHR$(0) + CHR$(80)
y = y + 5
CASE CHR$(0) + CHR$(72)
y = y - 5
CASE "Q"
EXIT DO
END SELECT
REM Draw the block at the new position
LINE (x, y)-(x + 20, y + 20), 2, BF
REM Draw eyes and a mouth
LINE (x + 3, y + 5)-(x + 6, y + 10), 15, BF
LINE (x + 12, y + 5)-(x + 15, y + 10), 15, BF
LINE (x + 8, y + 13)-(x + 11, y + 17), 15, BF
REM Array and check conditions
FOR i = 0 TO 20
nx(i) = x + i
ny(i) = y + i
NEXT i
FOR j = 0 TO 20
FOR k = 0 TO 20
IF nx(j) = RANDOMX AND ny(k) = RANDOMY THEN
ENEMY
SCORE = SCORE + 1
END IF
NEXT k
NEXT j
REM Wait for a bit before updating the position again
SLEEP 1
LOOP
END SUB

SUB CENTER (ROW, text$)
COL = 85 / 2
Col1 = COL - (LEN(text$) / 2 + .5)
LOCATE ROW, Col1
PRINT text$;
END SUB

SUB DISPLAY
SCREEN 12
COLOR 14
CENTER 15, "Blocks by Syaheer Altaf"
SCORE = 0
i = 5
WHILE i > 0
LOCATE 17, 40
PRINT i
i = i - 1
SLEEP 1
WEND
CLS
END SUB

SUB ENEMY
RANDOMIZE TIMER
RANDOMX = INT(RND * 635)
RANDOMY = INT(RND * 400)
LINE (RANDOMX, RANDOMY)-(RANDOMX + 9, RANDOMY + 9), 12, BF
END SUB

