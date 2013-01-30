

Unicode support in Cuis
------------------------------

Cuis has limited Unicode support.

Externally, this means for the clipboard UTF8 is used.

Internally the 8 bit ISO8959-15 is used (http://en.wikipedia.org/wiki/ISO/IEC_8859-15) . This means less than 255 code points. 
The rest is converted to numerical character entities when reading from a file or when text is pasted through the clipboard.


### Construction of example data for test


With the on-line converter http://rishida.net/tools/conversion/ example data may be constructed for tests.

abc αβγ


Decimal NCRs

    abc &#945;&#946;&#947;



Hexadecimal NCRs

    abc &#x03B1;&#x03B2;&#x03B3;


UTF8 code units

    61 62 63 20 CE B1 CE B2 CE B3



JavaScript escapes

    abc \u03B1\u03B2\u03B3



Write the data above as a UTF8 encoded file in binary mode.  

     | stream |

     stream := (FileStream newFileNamed: 'UTF8abc-test.txt') binary.

     stream nextPutAll: #[  16r61 16r62 16r63 16r20 16rCE 16rB1 16rCE 16rB2 16rCE 16rB3].

     stream close.
   

Read it back

      (FileStream fileNamed: 'UTF8abc-test.txt') contentsOfEntireFile utf8ToISO8859s15

gives the result

     'abc &#945;&#946;&#947;'


Note: #utf8ToISO8859s15 is only used by the clipboard. 