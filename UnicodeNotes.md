

Unicode support in Cuis
------------------------------

Cuis has limited Unicode support.

Externally, this means for the clipboard UTF8 is used. For files it is ISO8859-15.


Internally the 8 bit ISO8959-15 is used (http://en.wikipedia.org/wiki/ISO/IEC_8859-15) . This means less than 255 code points. 
The rest is converted to numerical character entities when reading from a file or when text is pasted through the clipboard.



### Construction of example data for UTF8 test


With the on-line converter http://rishida.net/tools/conversion/ example data may be constructed for tests.

abc àè€ αβγ (abc the a with gravis, e with gravis, euro sign, alpha, beta, gamma) 


Decimal NCRs

    abc &#224;&#232;&#8364; &#945;&#946;&#947;


Hexadecimal NCRs

    abc &#x00E0;&#x00E8;&#x20AC; &#x03B1;&#x03B2;&#x03B3;


UTF8 code units


    61 62 63 20 C3 A0 C3 A8 E2 82 AC 20 CE B1 CE B2 CE B3

UTF8 code units as Smalltalk literal array

    #[16r61 16r62 16r63 16r20 16rC3 16rA0 16rC3 16rA8 16rE2 
	16r82 16rAC 16r20 16rCE 16rB1 16rCE 16rB2 16rCE 16rB3]


JavaScript escapes

    abc \u00E0\u00E8\u20AC \u03B1\u03B2\u03B3


Write the data above as a UTF8 encoded file in binary mode.  

     | stream |

     stream := (FileStream newFileNamed: 'UTF8abc-test.txt') binary.
     stream nextPutAll: #[16r61 16r62 16r63 16r20 16rC3 16rA0 16rC3 16rA8 16rE2 
	                              16r82 16rAC 16r20 16rCE 16rB1 16rCE 16rB2 16rCE 16rB3].
     stream close.
   

Read it back

      (FileStream fileNamed: 'UTF8abc-test.txt') contentsOfEntireFile utf8ToISO8859s15

gives the result

      'abc �� &#945;&#946;&#947;'


Whereas
      
      (FileStream fileNamed: 'UTF8abc-test.txt') contentsOfEntireFile     

gives the result

      'abc àè€ αβγ'

which are the UTF8 bytes.


Note: #utf8ToISO8859s15 is only used by the clipboard. 


### Test with ISO8859-15 text file


    | stream |

     stream  := (FileStream newFileNamed: 'ISO8859-15abc-test.txt').
     32 to: 255 do: [ :code | stream nextPut: code asCharacter].
     stream close.


Reading it back


    (FileStream fileNamed: 'ISO8859-15abc-test.txt') contentsOfEntireFile


The default encoding for files is ISO8859-15.    


### Note about this file

Some characters might appear wrongly in this UnicodeNotes.md file. Do a test in the image with the UTF8 code units 
and the constructed ISO8859 file.
