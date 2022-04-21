Use Windows.pkg
Use DFClient.pkg
Use BitWise\BitWiseGlobalFunctions.pkg
Use cTextEdit.pkg
Use GlobalFunctionsProcedures.pkg
Use gFormatNumbers.pkg

Deferred_View Activate_oBitWise for ;
Object oBitWise is a dbView

    Set Border_Style to Border_Thick
    Set Size to 443 754
    Set Location to 3 1
    Set Label to "BitWise Functions"

    Object oContainer3d1 is a Container3d
        Set Size to 435 748
        Set Location to 4 3
        Set peAnchors to anAll
        
        // add  a . on every 4 bits for better visualization 
        Function sFormatBin String sBinStr Returns String 
            String sRet 
            While (Length(sBinStr) > 4 )
                Move (Insert("." + Right(sBinStr, 4 ), sRet, 1) ) to sRet
                Move (Left(sBinStr, Length(sBinStr) - 4)) to sBinStr 
            Loop
            If (sBinStr <> "") Move (Insert( sBinStr, sRet, 1) ) to sRet
            Function_Return sRet 
        End_Function
        
        Function sFormatBigInt String sBigInt Returns String 
            String sRet  sSignal
            Char iSep 
            
            Move (Trim(sBigInt)) to sBigInt
            If (Left(sBigInt, 1) = "-") Begin 
                Move "-" to sSignal
                Move (Remove(sBigInt, 1, 1)) to sBigInt
            End
            
            Get_Attribute DF_THOUSANDS_SEPARATOR to iSep
            While (Length(sBigInt) > 3 )
                Move (Insert(Character(iSep) + Right(sBigInt, 3 ), sRet, 1) ) to sRet
                Move (Left(sBigInt, Length(sBigInt) - 3)) to sBigInt 
            Loop
            If (sBigInt <> "") Move (Insert( sBigInt, sRet, 1) ) to sRet
            
            If (sSignal <> "") ; 
                Move (sSignal + sRet) to sRet 
            Function_Return sRet 
            
        End_Function 
        
        Function ValidateDecInput String sValue String ByRef sMin String ByRef sMax Returns Boolean 
            Integer iSign iBits 
            Boolean bRet 
            
            Get Current_Radio of oSignGrp to iSign
            Get Current_Radio of oBitnesgrp to iBits 
            
            Case Begin
                Case (iBits = 0) // 8 bits 
                    If (iSign  = 0) Begin 
                        Move ((Convert(sValue, BigInt) >= Convert(Cbit_Char_Min, BigInt)) and (Convert(sValue, BigInt) <= Convert(Cbit_Char_Max, BigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_Char_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_Char_Max, String)) to sMax 
                    End
                    Else Begin 
                        Move ((Convert(sValue, UBigInt) >= Convert(Cbit_uChar_Min, UBigInt)) and (Convert(sValue, UBigInt) <= Convert(Cbit_uChar_Max, UBigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_uChar_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_uChar_Max, String)) to sMax 
                    End
                    
                    Case Break 
                Case (iBits = 1) // 16 bits
                    If (iSign  = 0) Begin 
                        Move ((Convert(sValue, BigInt) >= Convert(Cbit_Short_Min, BigInt)) and (Convert(sValue, BigInt) <= Convert(Cbit_Short_Max, BigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_Short_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_Short_Max, String)) to sMax 
                    End
                    Else Begin 
                        Move ((Convert(sValue, UBigInt) >= Convert(Cbit_uShort_Min, UBigInt)) and (Convert(sValue, UBigInt) <= Convert(Cbit_uShort_Max, UBigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_uShort_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_uShort_Max, String)) to sMax 
                    End
                    
                    Case Break
                Case (iBits = 2) // 32 bits 
                    If (iSign  = 0) Begin 
                        Move ((Convert(sValue, BigInt) >= Convert(Cbit_Integer_Min, BigInt)) and (Convert(sValue, BigInt) <= Convert(Cbit_Integer_Max, BigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_Integer_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_Integer_Max, String)) to sMax 
                    End
                    Else Begin 
                        Move ((Convert(sValue, UBigInt) >= Convert(Cbit_uInteger_Min, UBigInt)) and (Convert(sValue, UBigInt) <= Convert(Cbit_uInteger_Max, UBigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_uInteger_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_uInteger_Max, String)) to sMax 
                    End

                    Case Break 
                Case Else // 64 bits 
                    If (iSign  = 0) Begin 
                        Move ((Convert(sValue, BigInt) >= Convert(Cbit_BigInt_Min, BigInt)) and (Convert(sValue, BigInt) <= Convert(Cbit_BigInt_Max, BigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_BigInt_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_BigInt_Max, String)) to sMax 
                    End
                    Else Begin 
                        Move ((Convert(sValue, UBigInt) >= Convert(Cbit_uBigInt_Min, UBigInt)) and (Convert(sValue, UBigInt) <= Convert(Cbit_uBigInt_Max, UBigInt))) to bRet 
                        Get sFormatBigInt (Convert(Cbit_uBigInt_Min, String)) to sMin 
                        Get sFormatBigInt (Convert(Cbit_uBigInt_Max, String)) to sMax 
                    End
                
            Case End
            
            Function_Return bRet 
        End_Function
        

        Object oBitnesgrp is a RadioGroup
            Set Size to 36 400
            
            Set Location to 10 3
            Set Label to "Bit size"

            Object oRadio1 is a Radio
                Set Size to 10 50
                Set Location to 16 53
                Set Label to "8 bits"
            End_Object

            Object oRadio2 is a Radio
                Set Size to 10 50
                Set Location to 16 137
                Set Label to "16 bits"
            End_Object

            Object oRadio3 is a Radio
                Set Size to 10 50
                Set Location to 16 225
                Set Label to "32 bits"
            End_Object

            Object oRadio4 is a Radio
                Set Size to 10 50
                Set Location to 16 312
                Set Label to "64 bits"
            End_Object
    
        End_Object

        Object oSignGrp is a RadioGroup
            Set Size to 36 206
            Set Location to 10 419
            Set Label to "Signed or not"

            Object oRadio5 is a Radio
                Set Size to 10 50
                Set Location to 16 40
                Set Label to "Signed"
            End_Object

            Object oRadio6 is a Radio
                Set Size to 10 50
                Set Location to 16 117
                Set Label to "Un-Signed"
            End_Object
        End_Object

        Object oTextBox1 is a TextBox
            Set Size to 10 49
            Set Location to 50 69
            Set Label to "Decimal Values"
        End_Object

        Object oInput1 is a Form
            Set Size to 12 150
            Set Location to 73 26
            Set Label to "Input Value 1"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Form_Datatype to Mask_Numeric_Window
            Set Form_Mask to ",*0"
            Set Typeface to "Consolas"
        
            Function Validate Returns Boolean 
                Boolean bRet 
                String  sMin sMax sValue 
                
                Get Value to sValue 
                
                Get ValidateDecInput sValue (&sMin) (&sMax) to bRet 
                
                    
                If (not(bret)) ;
                    Send Stop_Box (SFormat("Input Value1 out of supported range of '%1' to '%2'", sMin, sMax)) 
                
                Function_Return bRet 
            End_Function
                        
        
        End_Object

        Object oInput2 is a Form
            Set Size to 12 150
            Set Location to 98 26
            Set Label to "Input Value 2"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Typeface to "Consolas"
            Set Form_Mask to ",*0"
            Set Form_Datatype to Mask_Numeric_Window
        
            Function Validate Returns Boolean 
                Boolean bRet 
                String  sMin sMax sValue

                Get Value to sValue 
                
                Get ValidateDecInput sValue (&sMin) (&sMax) to bRet 
                
                    
                If (not(bret)) ;
                    Send Stop_Box (SFormat("Input Value2 out of supported range of '%1' to '%2'", sMin, sMax)) 
                      
                Function_Return bRet 
            End_Function

        
        End_Object

        Object oExecBtn is a Button
            Set Size to 14 66
            Set Location to 80 243
            Set Label to "Execute"
        
            // fires when the button is clicked
            Procedure OnClick
                Boolean bValid1 bValid2
                Integer iSign iBits 
                UBigInt ubiVal1 ubiVal2
                String[] sRet 
                String  sBitRet 
                
                Get Validate of oInput1 to bValid1
                Get Validate of oInput2 to bValid2
                
                If (not(bValid1)  or not(bValid2)) ;
                    Procedure_Return 
                
                
                Get Current_Radio of oSignGrp to iSign
                Get Current_Radio of oBitnesgrp to iBits 
                
                Get Value of oInput1 to ubiVal1 
                Get Value of oInput2 to ubiVal2 
                
                Case Begin
                    Case (iBits = 0) // 8 bits 
                        Set Form_Mask of oValue1_bin to "####.####"
                        Set Form_Mask of oValue2_bin to "####.####"

                        Move (fBitRepresentation_8bits( Convert(ubiVal1, UChar) ) ) to sRet 
                        Set Value of oValue1_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                        Move (fBitRepresentation_8bits( Convert(ubiVal2, UChar) ) ) to sRet 
                        Set Value of oValue2_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                        
                        // AND
                        If (iSign) Get fBit_AND_uChar (Convert(ubival1, UChar)) (Convert(ubiVal2, UChar)) to sBitRet 
                        Else       Get fBit_AND_Char  (Convert(ubival1, Char))  (Convert(ubiVal2, Char))  to sBitRet 
                        Get fBitRepresentation_8bits (Convert(sBitRet, UChar)) to sRet 
                        Send UpdateValue of oANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_OR_uChar (Convert(ubival1, UChar)) (Convert(ubiVal2, UChar)) to sBitRet 
                        Else       Get fBit_OR_Char  (Convert(ubival1, Char))  (Convert(ubiVal2, Char))  to sBitRet 
                        Get fBitRepresentation_8bits (Convert(sBitRet, UChar)) to sRet 
                        Send UpdateValue of oORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // NAND 
                        If (iSign) Get fBit_NAND_uChar (Convert(ubival1, UChar)) (Convert(ubiVal2, UChar)) to sBitRet 
                        Else       Get fBit_NAND_Char  (Convert(ubival1, Char))  (Convert(ubiVal2, Char))  to sBitRet 
                        Get fBitRepresentation_8bits (Convert(sBitRet, UChar)) to sRet 
                        Send UpdateValue of oNANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_XOR_uChar (Convert(ubival1, UChar)) (Convert(ubiVal2, UChar)) to sBitRet 
                        Else       Get fBit_XOR_Char  (Convert(ubival1, Char))  (Convert(ubiVal2, Char))  to sBitRet 
                        Get fBitRepresentation_8bits (Convert(sBitRet, UChar)) to sRet 
                        Send UpdateValue of oXORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        
                                  
                        
                        Case Break
                    Case (iBits = 1) // 16 bits 
                        Set Form_Mask of oValue1_bin to "####.####.####.####"
                        Set Form_Mask of oValue2_bin to "####.####.####.####"

                        Move (fBitRepresentation_16bits( Convert(ubiVal1, UShort) )) to sRet 
                        Set Value of oValue1_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                        Move (fBitRepresentation_16bits( Convert(ubiVal2, UShort) )) to sRet 
                        Set Value of oValue2_bin to (StrJoinFromArray(ReverseArray(sRet), ""))

                        // AND
                        If (iSign) Get fBit_AND_uShort (Convert(ubival1, UShort)) (Convert(ubiVal2, UShort)) to sBitRet 
                        Else       Get fBit_AND_Short  (Convert(ubival1, Short))  (Convert(ubiVal2, Short))  to sBitRet 
                        Get fBitRepresentation_16bits (Convert(sBitRet, UShort)) to sRet 
                        Send UpdateValue of oANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_OR_uShort (Convert(ubival1, UShort)) (Convert(ubiVal2, UShort)) to sBitRet 
                        Else       Get fBit_OR_Short  (Convert(ubival1, Short))  (Convert(ubiVal2, Short))  to sBitRet 
                        Get fBitRepresentation_16bits (Convert(sBitRet, UShort)) to sRet 
                        Send UpdateValue of oORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // NAND 
                        If (iSign) Get fBit_NAND_uShort (Convert(ubival1, UShort)) (Convert(ubiVal2, UShort)) to sBitRet 
                        Else       Get fBit_NAND_Short  (Convert(ubival1, Short))  (Convert(ubiVal2, Short))  to sBitRet 
                        Get fBitRepresentation_16bits (Convert(sBitRet, UShort)) to sRet 
                        Send UpdateValue of oNANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_XOR_uShort (Convert(ubival1, UShort)) (Convert(ubiVal2, UShort)) to sBitRet 
                        Else       Get fBit_XOR_Short  (Convert(ubival1, Short))  (Convert(ubiVal2, Short))  to sBitRet 
                        Get fBitRepresentation_16bits (Convert(sBitRet, UShort)) to sRet 
                        Send UpdateValue of oXORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                    
                        Case Break
                    Case (iBits = 2) // 32 bits 
                        Set Form_Mask of oValue1_bin to "####.####.####.####.####.####.####.####"
                        Set Form_Mask of oValue2_bin to "####.####.####.####.####.####.####.####"

                        Move (fBitRepresentation_32bits( Convert(ubiVal1, UInteger) )) to sRet 
                        Set Value of oValue1_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                        Move (fBitRepresentation_32bits( Convert(ubiVal2, UInteger) )) to sRet 
                        Set Value of oValue2_bin to (StrJoinFromArray(ReverseArray(sRet), ""))

                        // AND 
                        If (iSign) Get fBit_AND_uInteger (Convert(ubival1, UInteger)) (Convert(ubiVal2, UInteger)) to sBitRet 
                        Else       Get fBit_AND_Integer  (Convert(ubival1, Integer))  (Convert(ubiVal2, Integer))  to sBitRet 
                        Get fBitRepresentation_32bits (Convert(sBitRet, UInteger)) to sRet 
                        Send UpdateValue of oANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_OR_uInteger (Convert(ubival1, UInteger)) (Convert(ubiVal2, UInteger)) to sBitRet 
                        Else       Get fBit_OR_Integer  (Convert(ubival1, Integer))  (Convert(ubiVal2, Integer))  to sBitRet 
                        Get fBitRepresentation_32bits (Convert(sBitRet, UInteger)) to sRet 
                        Send UpdateValue of oORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // NAND 
                        If (iSign) Get fBit_NAND_uInteger (Convert(ubival1, UInteger)) (Convert(ubiVal2, UInteger)) to sBitRet 
                        Else       Get fBit_NAND_Integer  (Convert(ubival1, Integer))  (Convert(ubiVal2, Integer))  to sBitRet 
                        Get fBitRepresentation_32bits (Convert(sBitRet, UInteger)) to sRet 
                        Send UpdateValue of oNANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_XOR_uInteger (Convert(ubival1, UInteger)) (Convert(ubiVal2, UInteger)) to sBitRet 
                        Else       Get fBit_XOR_Integer  (Convert(ubival1, Integer))  (Convert(ubiVal2, Integer))  to sBitRet 
                        Get fBitRepresentation_32bits (Convert(sBitRet, UInteger)) to sRet 
                        Send UpdateValue of oXORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                    
                        Case Break
                    Case Else // 64 bits 
                        Set Form_Mask of oValue1_bin to "####.####.####.####.####.####.####.####.####.####.####.####.####.####.####.####"
                        Set Form_Mask of oValue2_bin to "####.####.####.####.####.####.####.####.####.####.####.####.####.####.####.####" 

                        Move (fBitRepresentation_64bits( ubiVal1)) to sRet 
                        Set Value of oValue1_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                        Move (fBitRepresentation_64bits(ubiVal2)) to sRet 
                        Set Value of oValue2_bin to (StrJoinFromArray(ReverseArray(sRet), ""))
                    
                        // AND 
                        If (iSign) Get fBit_AND_uBigInt ubiVal1                     ubiVal2                     to sBitRet // no need to convert. 
                        Else       Get fBit_AND_BigInt  (Convert(ubival1, BigInt )) (Convert(ubiVal2, BigInt))  to sBitRet 
                        Get fBitRepresentation_64bits (Convert(sBitRet, UBigInt)) to sRet 
                        Send UpdateValue of oANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_OR_uBigInt ubiVal1                     ubiVal2                     to sBitRet // no need to convert. 
                        Else       Get fBit_OR_BigInt  (Convert(ubival1, BigInt))  (Convert(ubiVal2, BigInt))  to sBitRet 
                        Get fBitRepresentation_64bits (Convert(sBitRet, UBigInt)) to sRet 
                        Send UpdateValue of oORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // NAND 
                        If (iSign) Get fBit_NAND_uBigInt ubiVal1                     ubiVal2                     to sBitRet // no need to convert. 
                        Else       Get fBit_NAND_BigInt  (Convert(ubival1, BigInt))  (Convert(ubiVal2, BigInt))  to sBitRet 
                        Get fBitRepresentation_64bits (Convert(sBitRet, UBigInt)) to sRet 
                        Send UpdateValue of oNANDText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        // OR 
                        If (iSign) Get fBit_XOR_uBigInt ubiVal1                     ubiVal2                     to sBitRet // no need to convert. 
                        Else       Get fBit_XOR_BigInt  (Convert(ubival1, BigInt))  (Convert(ubiVal2, BigInt))  to sBitRet 
                        Get fBitRepresentation_64bits (Convert(sBitRet, UBigInt)) to sRet 
                        Send UpdateValue of oXORText sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                    
                Case End
                
            End_Procedure
        
        End_Object

        Object oValue1_bin is a Form
            Set Size to 12 344
            Set Location to 73 374
            Set Label to "Value 1 (binary representation)"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Form_Datatype to Mask_Window
            
            Set Typeface to "Consolas"
            Set Entry_State to False
            Set Form_Justification_Mode to (Form_DisplayRight ior Form_EditRight)
        
       
        End_Object

        Object oValue2_bin is a Form
            Set Size to 12 344
            Set Location to 98 374
            Set Label to "Value 2 (binary representation)"
            Set Label_Col_Offset to 0
            Set Label_Justification_Mode to JMode_Top
            Set Form_Datatype to Mask_Window
            Set Typeface to "Consolas"
            Set Entry_State to False
            Set Form_Justification_Mode to (Form_DisplayRight ior Form_EditRight)
        
       
        End_Object

        Object oANDText is a cTextEdit
            Set Size to 54 361
            Set Location to 127 7
            Set Label to "AND ( && )"
            Set psTypeFace to "Consolas"
            Set Read_Only_State to True
            
            Procedure UpdateValue String sDecResult String sBinResult 
                String sBin1 sBin2 
                
                Get Value of oValue1_bin to sBin1 
                If (sBin1 = "") Move "0" to sBin1
                Get Value of oValue2_bin to sBin2
                If (sBin2 = "") Move "0" to sBin2 
                
                Send Delete_Data 
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin1) ) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin2) ) )
                Send AppendTextLn (SFormat("&  - %1", FillString("-", (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinResult) ) )
                If (Length(sDecResult) > 14) ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Else ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + FormatNumber(sDecResult, 0), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                 
                
            End_Procedure
        End_Object

        Object oORText is a cTextEdit
            Set Size to 54 361
            Set Location to 127 375
            Set Label to "OR ( | )"
            Set psTypeFace to "Consolas"
            Set Read_Only_State to True

            Procedure UpdateValue String sDecResult String sBinResult 
                String sBin1 sBin2 
                
                Get Value of oValue1_bin to sBin1 
                If (sBin1 = "") Move "0" to sBin1
                Get Value of oValue2_bin to sBin2
                If (sBin2 = "") Move "0" to sBin2 
                
                Send Delete_Data 
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin1) ) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin2) ) )
                Send AppendTextLn (SFormat("|  - %1", FillString("-", (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinResult) ) )
                If (Length(sDecResult) > 14) ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Else ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + FormatNumber(sDecResult, 0), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                    
            End_Procedure

        End_Object

        Object oNANDText is a cTextEdit
            Set Size to 54 361
            Set Location to 200 7
            Set Label to "NAND ~(a iand b )"
            Set psTypeFace to "Consolas"
            Set Read_Only_State to True

            Procedure UpdateValue String sDecResult String sBinResult 
                String sBin1 sBin2 
                
                Get Value of oValue1_bin to sBin1 
                If (sBin1 = "") Move "0" to sBin1
                Get Value of oValue2_bin to sBin2
                If (sBin2 = "") Move "0" to sBin2 
                
                Send Delete_Data 
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin1) ) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin2) ) )
                Send AppendTextLn (SFormat("~& - %1", FillString("-", (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinResult) ) )
                If (Length(sDecResult) > 14) ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Else ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + FormatNumber(sDecResult, 0), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                
            End_Procedure
        End_Object

        Object oXORText is a cTextEdit
            Set Size to 54 361
            Set Location to 201 375
            Set Label to "XOR ( ^ ) "
            Set psTypeFace to "Consolas"
            Set Read_Only_State to True

            Procedure UpdateValue String sDecResult String sBinResult 
                String sBin1 sBin2 
                
                Get Value of oValue1_bin to sBin1 
                If (sBin1 = "") Move "0" to sBin1
                Get Value of oValue2_bin to sBin2
                If (sBin2 = "") Move "0" to sBin2 
                
                Send Delete_Data 
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin1) ) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBin2) ) )
                Send AppendTextLn (SFormat("^  - %1", FillString("-", (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinResult) ) )
                If (Length(sDecResult) > 14) ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                Else ; 
                    Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBin1) +  (Length(sBin1)/4) -1) + FormatNumber(sDecResult, 0), (Length(sBin1) +  (Length(sBin1)/4) -1) )) )
                 
                
            End_Procedure
        End_Object

        Object oNOTGrp is a Group
            Set Size to 65 729
            Set Location to 275 7
            Set Label to "NOT or Complement"

            Object oNotInput is a Form
                Set Size to 12 150
                Set Location to 27 17
                Set Label to "Value"
                Set Label_Col_Offset to 0
                Set Label_Justification_Mode to JMode_Top
                Set Typeface to "Consolas"
                Set Form_Datatype to Mask_Numeric_Window
                Set Form_Mask to ",*0"
            
                Function Validate Returns Boolean 
                    Boolean bRet 
                    String  sMin sMax sValue 
                    
                    Get Value to sValue 
                    
                    Get ValidateDecInput sValue (&sMin) (&sMax) to bRet 
                    
                        
                    If (not(bret)) ;
                        Send Stop_Box (SFormat("Input Value for NOT is out of supported range of '%1' to '%2'", sMin, sMax)) 
                    
                    Function_Return bRet 
                End_Function

            
            End_Object

            Object oNOTBtn is a Button
                Set Size to 14 66
                Set Location to 25 223
                Set Label to "NOT (~)"
            
                // fires when the button is clicked
                Procedure OnClick

                    Boolean bValid1
                    Integer iSign iBits 
                    UBigInt ubiVal1 
                    String[] sRet saBitInput
                    String  sBitRet 
                    
                    Get Validate of oNotInput to bValid1
                    If (not(bValid1)) ;
                        Procedure_Return 
                    
                    
                    Get Current_Radio of oSignGrp to iSign
                    Get Current_Radio of oBitnesgrp to iBits 
                    
                    Get Value of oNotInput to ubiVal1 
                    
                    Case Begin
                        Case (iBits = 0) // 8 bits 
                            // NOT
                            Get fBitRepresentation_8bits  (Convert(ubiVal1, UChar)) to saBitInput
                            If (iSign) Get fBit_NOT_uChar (Convert(ubival1, UChar)) to sBitRet 
                            Else       Get fBit_NOT_Char  (Convert(ubival1, Char))  to sBitRet 
                            Get fBitRepresentation_8bits  (Convert(sBitRet, UChar)) to sRet 
                            Send UpdateValue of oNOTText  (StrJoinFromArray(ReverseArray(saBitInput), "")) sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                            
                            Case Break
                        Case (iBits = 1) // 16 bits 
    
                            // NOT
                            Get fBitRepresentation_16bits  (Convert(ubiVal1, UShort)) to saBitInput
                            If (iSign) Get fBit_NOT_uShort (Convert(ubival1, UShort)) to sBitRet 
                            Else       Get fBit_NOT_Short  (Convert(ubival1, Short))  to sBitRet 
                            Get fBitRepresentation_16bits  (Convert(sBitRet, UShort)) to sRet 
                            Send UpdateValue of oNOTText   (StrJoinFromArray(ReverseArray(saBitInput), "")) sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        
                            Case Break
                        Case (iBits = 2) // 32 bits 
                            // NOT
                            Get fBitRepresentation_32bits  (Convert(ubiVal1, UInteger))     to saBitInput
                            If (iSign) Get fBit_NOT_uInteger (Convert(ubival1, UInteger)) to sBitRet 
                            Else       Get fBit_NOT_Integer  (Convert(ubival1, Integer))  to sBitRet 
                            Get fBitRepresentation_32bits    (Convert(sBitRet, UInteger)) to sRet 
                            Send UpdateValue of oNOTText     (StrJoinFromArray(ReverseArray(saBitInput), "")) sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        
                            Case Break
                        Case Else // 64 bits 
                            // NOT
                            Get fBitRepresentation_64bits  (Convert(ubiVal1, UBigInt)) to saBitInput
                            If (iSign) Get fBit_NOT_uBigInt ubiVal1                     to sBitRet // no need to convert. 
                            Else       Get fBit_NOT_BigInt  (Convert(ubival1, BigInt )) to sBitRet 
                            Get fBitRepresentation_64bits (Convert(sBitRet, UBigInt))  to sRet 
                            Send UpdateValue of oNOTText  (StrJoinFromArray(ReverseArray(saBitInput), "")) sBitRet (StrJoinFromArray(ReverseArray(sRet), ""))
                        
                    Case End
                    
                End_Procedure
            
            End_Object

            Object oNOTText is a cTextEdit
                Set Size to 44 408
                Set Location to 15 311
                Set psTypeFace to "Consolas"
                Set Read_Only_State to True

                Procedure UpdateValue String sBinInput String sDecResult String sBinResult 
                    
                    Send Delete_Data 
                    Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinInput) ) )
                    
                    Send AppendTextLn (SFormat("~  - %1", FillString("-", (Length(sBinInput) +  (Length(sBinInput)/4) -1) )) )
                    Send AppendTextLn (SFormat("b  - %1", sFormatBin(Self, sBinResult) ) )
                    If (Length(sDecResult) > 14) ; 
                        Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBinInput) +  (Length(sBinInput)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBinInput) +  (Length(sBinInput)/4) -1) )) )
                    Else ; 
                        Send AppendText   (SFormat("d  - %1", Right(FillString(" ", Length(sBinInput) +  (Length(sBinInput)/4) -1) + FormatNumber(sDecResult, 0), (Length(sBinInput) +  (Length(sBinInput)/4) -1) )) )
                     
                    
                End_Procedure
                
            End_Object
        End_Object

        Object oShiftGrp is a Group
            Set Size to 82 727
            Set Location to 343 9
            Set Label to "Shift By"
            Set peAnchors to anBottomLeftRight

            Object oShiftValue is a Form
                Set Size to 12 150
                Set Location to 25 17
                Set Label to "Value"
                Set Label_Col_Offset to 0
                Set Label_Justification_Mode to JMode_Top
                Set Typeface to "Consolas"
                Set Form_Datatype to Mask_Numeric_Window
                Set Form_Mask to ",*0"
            
                Function Validate Returns Boolean 
                    Boolean bRet 
                    String  sMin sMax sValue 
                    
                    Get Value to sValue 
                    
                    Get ValidateDecInput sValue (&sMin) (&sMax) to bRet 
                    
                        
                    If (not(bret)) ;
                        Send Stop_Box (SFormat("Input Value for Shift is out of supported range of '%1' to '%2'", sMin, sMax)) 
                    
                    Function_Return bRet 
                End_Function
            
            End_Object

            Object oShiftBy is a SpinForm
                Set Size to 12 100
                Set Location to 54 19
                Set Label to "Shift By (bits)"
                Set Label_Col_Offset to 0
                Set Label_Justification_Mode to JMode_Top
                Set Typeface to "Consolas"
                Set Form_Datatype to Mask_Numeric_Window
                Set Form_Justification_Mode to Form_DisplayRight
                Set Maximum_Position to 65
                Set Minimum_Position to 0
                Set Form_Mask to "*0"
            
            End_Object
            
            Procedure PerformShift Integer eType 
                Boolean bValid1 
                UBigInt ubiVal1
                Integer iSign iBits iBy 
                String[] saBitInput  saShifted
                String sDecInput sDecRet 
                
                Get Validate of oShiftValue to bValid1
                If (not(bValid1)) ;
                    Procedure_Return 

                Get Current_Radio of oSignGrp to iSign
                Get Current_Radio of oBitnesgrp to iBits 

                Get Value of oShiftValue to ubiVal1
                Get Value of oShiftValue to sDecInput
                Get Value of oShiftBy    to iBy 
                
                Case Begin
                    Case (iBits = 0) // 8 bits 
                        Move (fBitRepresentation_8bits( Convert(ubiVal1, UChar) ) ) to saBitInput 
                        
                        Case Begin 
                            Case (eType = 0) // Shift-Right-A 
                                If (iSign) Get fBit_RightShiftA_uChar (Convert(sDecInput, UChar)) iBy to sDecRet 
                                Else       Get fBit_RightShiftA_Char  (Convert(sDecInput, Char))  iBy to sDecRet 
                                Get fBitRepresentation_8bits (Convert(sDecRet, UChar)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "a>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                                                    
                                Case Break 
                            Case (eType = 1) // Shift-Right-L 
                                If (iSign) Get fBit_RightShiftL_uChar (Convert(sDecInput, UChar)) iBy to sDecRet 
                                Else       Get fBit_RightShiftL_Char  (Convert(sDecInput, Char))  iBy to sDecRet 
                                Get fBitRepresentation_8bits (Convert(sDecRet, UChar)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "l>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                
                                Case Break 
                            Case Else // Shift-Left
                                If (iSign) Get fBit_LeftShift_uChar (Convert(sDecInput, UChar)) iBy to sDecRet 
                                Else       Get fBit_LeftShift_Char  (Convert(sDecInput, Char))  iBy to sDecRet 
                                Get fBitRepresentation_8bits (Convert(sDecRet, UChar)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "<< " sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                            
                        Case End
                        
                        Case Break
                    Case (iBits = 1) // 16 bits 
                        Move (fBitRepresentation_16bits( Convert(ubiVal1, UShort) ) ) to saBitInput 

                        Case Begin 
                            Case (eType = 0) // Shift-Right-A 
                                If (iSign) Get fBit_RightShiftA_uShort (Convert(sDecInput, UShort)) iBy to sDecRet 
                                Else       Get fBit_RightShiftA_Short  (Convert(sDecInput, Short))  iBy to sDecRet 
                                Get fBitRepresentation_16bits (Convert(sDecRet, UShort)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "a>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                                                    
                                Case Break 
                            Case (eType = 1) // Shift-Right-L 
                                If (iSign) Get fBit_RightShiftL_uShort (Convert(sDecInput, UShort)) iBy to sDecRet 
                                Else       Get fBit_RightShiftL_Short  (Convert(sDecInput, Short))  iBy to sDecRet 
                                Get fBitRepresentation_16bits (Convert(sDecRet, UShort)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "l>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                
                                Case Break 
                            Case Else // Shift-Left
                                If (iSign) Get fBit_LeftShift_uShort (Convert(sDecInput, UShort)) iBy to sDecRet 
                                Else       Get fBit_LeftShift_Short  (Convert(sDecInput, Short))  iBy to sDecRet 
                                Get fBitRepresentation_16bits (Convert(sDecRet, UShort)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "<< " sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                            
                        Case End

                        Case Break
                    Case (iBits = 2) // 32 bits 
                        Move (fBitRepresentation_32bits( Convert(ubiVal1, UInteger) ) ) to saBitInput 

                        Case Begin 
                            Case (eType = 0) // Shift-Right-A 
                                If (iSign) Get fBit_RightShiftA_uInteger (Convert(sDecInput, UInteger)) iBy to sDecRet 
                                Else       Get fBit_RightShiftA_Integer  (Convert(sDecInput, Integer))  iBy to sDecRet 
                                Get fBitRepresentation_32bits (Convert(sDecRet, UInteger)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "a>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                                                    
                                Case Break 
                            Case (eType = 1) // Shift-Right-L 
                                If (iSign) Get fBit_RightShiftL_uInteger (Convert(sDecInput, UInteger)) iBy to sDecRet 
                                Else       Get fBit_RightShiftL_Integer  (Convert(sDecInput, Integer))  iBy to sDecRet 
                                Get fBitRepresentation_32bits (Convert(sDecRet, UInteger)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "l>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                
                                Case Break 
                            Case Else // Shift-Left
                                If (iSign) Get fBit_LeftShift_uInteger (Convert(sDecInput, UInteger)) iBy to sDecRet 
                                Else       Get fBit_LeftShift_Integer  (Convert(sDecInput, Integer))  iBy to sDecRet 
                                Get fBitRepresentation_32bits (Convert(sDecRet, UInteger)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "<< " sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                            
                        Case End

                        Case Break
                    Case Else // 64 bits 
                        Move (fBitRepresentation_64bits( ubiVal1 )) to saBitInput 

                        Case Begin 
                            Case (eType = 0) // Shift-Right-A 
                                If (iSign) Get fBit_RightShiftA_uBigInt (Convert(sDecInput, UBigInt)) iBy to sDecRet 
                                Else       Get fBit_RightShiftA_BigInt  (Convert(sDecInput, BigInt))  iBy to sDecRet 
                                Get fBitRepresentation_64bits (Convert(sDecRet, UBigInt)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "a>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                                                    
                                Case Break 
                            Case (eType = 1) // Shift-Right-L 
                                If (iSign) Get fBit_RightShiftL_uBigInt (Convert(sDecInput, UBigInt)) iBy to sDecRet 
                                Else       Get fBit_RightShiftL_BigInt  (Convert(sDecInput, BigInt))  iBy to sDecRet 
                                Get fBitRepresentation_64bits (Convert(sDecRet, UBigInt)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "l>>" sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                                
                                Case Break 
                            Case Else // Shift-Left
                                If (iSign) Get fBit_LeftShift_uBigInt (Convert(sDecInput, UBigInt)) iBy to sDecRet 
                                Else       Get fBit_LeftShift_BigInt  (Convert(sDecInput, BigInt))  iBy to sDecRet 
                                Get fBitRepresentation_64bits (Convert(sDecRet, UBigInt)) to saShifted 
                                Send UpdateValue of oShiftText (StrJoinFromArray(ReverseArray(saBitInput), "")) "<< " sDecRet (StrJoinFromArray(ReverseArray(saShifted), "")) 
                            
                        Case End

                Case End
            End_Procedure

            Object oShiftRA is a Button
                Set Size to 14 102
                Set Location to 16 200
                Set Label to "Arithmetic Shift Right (a>>)"
            
                // fires when the button is clicked
                Procedure OnClick
                    Send PerformShift 0 
                End_Procedure
            
            End_Object

            Object oShiftRL is a Button
                Set Size to 14 102
                Set Location to 37 200
                Set Label to "Logical Shift Right (l>>)"
            
                // fires when the button is clicked
                Procedure OnClick
                    Send PerformShift 1
                End_Procedure
            
            End_Object

            Object oShiftLeft is a Button
                Set Size to 14 102
                Set Location to 58 200
                Set Label to "Shift Left (<<)"
            
                // fires when the button is clicked
                Procedure OnClick
                    Send PerformShift 2
                End_Procedure
            
            End_Object

            Object oShiftText is a cTextEdit
                Set Size to 57 408
                Set Location to 15 311
                Set peAnchors to anTopLeftRight
                Set psTypeFace to "Consolas"
                Set Read_Only_State to True

                Procedure UpdateValue String sBinInput String sType String sDecResult String sBinResult 
                    String sDecInput 
                    
                    Send Delete_Data 
                    Get Value of oShiftValue to sDecInput 
                    Send AppendTextLn (SFormat("d - %1", Right(FillString(" ", Length(sBinInput) +  (Length(sBinInput)/4) -1) + (sFormatBigInt(Self, sDecInput)), (Length(sBinInput) +  (Length(sBinInput)/4) -1) ) )) 
                    Send AppendTextLn (SFormat("b - %1", sFormatBin(Self, sBinInput) ) )
                    
                    Send AppendTextLn (SFormat("  - %1 | %2 by %3",  FillString("-", (Length(sBinInput) +  (Length(sBinInput)/4) -1) ), Trim(sType), If(Value(oShiftBy) = "", "0", Value(oShiftBy)) ) )
                    Send AppendTextLn (SFormat("b - %1", sFormatBin(Self, sBinResult) ) )
                    Send AppendText   (SFormat("d - %1", Right(FillString(" ", Length(sBinInput) +  (Length(sBinInput)/4) -1) + (sFormatBigInt(Self, sDecResult)), (Length(sBinInput) +  (Length(sBinInput)/4) -1) )) )
                    
                End_Procedure
                
            End_Object
        End_Object

    End_Object

Cd_End_Object
