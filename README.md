# BitWise Functions
Bit wise global functions for DataFlex 

BitWiseGlobalFunctions.pkg is a dataflex package that includes several bitwise functions extending the natives *ior* and *iand* DF built-in commands. 

It also supports all types of integer flavours: 
- 8, 16, 32 and 64 bits (char, short, integer, bigint)
- Signed or Un-signed integers 


## Main Functions 
```

| =========== | ================== | ======================================================= | ============================ |
| Oparation   | Function           | Description                                             | Example                      | 
| =========== | ================== | ======================================================= | ============================ |
|    AND      | fBit_AND_*         | binary AND                                              |  00001100 =   12             |
|             |                    | Result is 1 if corresponding bit of two operands is 1.  |  00011001 =   25             |
|   C (&)     |                    |                                                         |  --------   ----             |
|             |                    |                                                         |  00001000 =    8             |
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
|    OR       | fBit_OR_*          | binary OR.                                              |  00001100 =   12             |
|             |                    |  result is 1 if at least one corresponding              |  00011001 =   25             |
|   C (|)     |                    |  bit of two operanda is 1.                              |  --------   ----             |
|             |                    |                                                         |  00011101 =   29             |
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
|    XOR      | fBit_XOR_*         | binary XOR (Exclusive OR)                               |  00001100 =   12             |
|             |                    |   Result is 1 if the corresponding bit of two operants  |  00011001 =   25             |
|   C (^)     |                    |   are opposite/different.                               |  --------   ----             |
|             |                    |                                                         |  00010101 =   21             |
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
|    NOT      | fBit_NOT_*         | binary NOT (or complement) - Unary function             |  00100011 =   35             |
|             |                    |   Changes bits: 1 to 0 and 0 to 1                       |  --------   ----             |
|   C (~)     |                    |                                                         |  11011100 =  -36 if singed   |
|             |                    |                                                         |          or  220 if unsigned |
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
|   NAND      | fBit_NAND_*        | binary NAND (NOT AND)                                   |  00001100 =   12             |
|             |                    |   Result is 1 if the corresponding bit of two operants  |  00011001 =   25             |
|   C (^)     |                    |   are 0. Equivalent to ~(a & b)                         |  --------   ----             |
|             |                    |                                                         |  11101010 =  -22 if signed   |
|             |                    |                                                         |          or  234 if unsigned |
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
| Right Shift | fBit_RightShiftA_* | Arithmetic Right Shift.                                 |  11010100 =  -44 (u212) by 2 |
|             |                    | shifts all bits towards right by certain number of bits |  --------   ----             |
| Arithmetic  |                    |   The left most bit (MSB) is preserved.                 |  11110101 =  -11 if singed   |
|             |                    |   The right most bit (LSB) is discarted.                |          or  245 if unsigned | 
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
| Right Shift | fBit_RightShiftL_* | Logic Right Shift.                                      |  11010100 =  -44 (u212) by 2 |
|   Logic     |                    | shifts all bits towards right by certain number of bits |  --------   ----             |
|             |                    |   The left most bit (MSB) is not preserved, becomes 0.  |  00110101 =   53             |
|   C (>>)    |                    |   The right most bit (LSB) is discarted.                |                              | 
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
| Left Shift  | fBit_LeftShift_*   | Left Shift.                                             |  11010101 =  -43 (u213) by 2 |
|       c     |                    | shifts all bits towards left by certain number of bits  |  --------   ----             |
|             |                    |   The left most bit (MSB) is discarted.                 |  01010100 =   84             |
|   C (<<)    |                    |   The right most bit (LSB) becomes 0.                   |                              | 
| ----------- | ------------------ | ------------------------------------------------------- | ---------------------------- |
```

## Auxiliar Functions 

- IsFlagIn_* : Determine if a bit-flag is present (set) in a given value. 
- SetFlagIn_*: Set a given bit-flag to 'ON (1)'.
- UnSetFlagIn_* : Un-Set a given bit-flag to 'OFF (0)' in Value. 
- fBitRepresentation_*: Returns a string array from any 10-base integer input value to it's 2-base (binary) representation. 

## Demo View
BitWise.vw is a demo view where all of these functions can be tested. 