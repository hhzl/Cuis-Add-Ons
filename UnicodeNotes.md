

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

gives the result below. The result appears correctly in the Cuis image but not in this UnicodeNotes.md file as this is a UTF8 file 
and thus does not show ISO8859-15 properly.

      'abc �� &#945;&#946;&#947;'


Whereas
      
      (FileStream fileNamed: 'UTF8abc-test.txt') contentsOfEntireFile     

gives the result

      'abc àè€ αβγ'

which are the UTF8 bytes. Again here in this UnicodeNotes.md file this appears correctly whereas in the Cuis image it does not.



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

Some characters might appear wrongly in this UnicodeNotes.md file. 
It is recommended to do the tests mentioned above in an recent Cuis image with the UTF8 code units 
and the constructed ISO8859 file.


### Implementation in Cuis 4.1


#### Class Character
    Magnitude subclass: #Character
	instanceVariableNames: 'value'
	classVariableNames: 'CharacterTable ClassificationTable LetterBits LowercaseBit 
	                     UnaccentedTable UnicodeCodePoints UppercaseBit'
	poolDictionaries: ''
	category: 'Kernel-Text'

Comment:
I represent a character by storing its associated Latin-9 code (ISO 8859-15). My instances are created uniquely, 
so that all instances of a character ($R, for example) are identical.


The class variable UnicodeCodePoints contains the Unicode values with which Cuis can deal. It is initialized with
    Character initializeUnicodeCodePoints
    

In a pristine Cuis image initialization has been done.

    initializeUnicodeCodePoints

	"Initialize the table of Unicode code points"
	UnicodeCodePoints _ Array new: 256.
	0 to: 255 do: [ :code |
		UnicodeCodePoints at: code + 1 put: code ].
	
	"The following codes are different in ISO 8859-15 from those in ISO 8859-1,
	so the character code is not equal to the Unicode code point"
	UnicodeCodePoints at: 16rA4+1 put: 16r20AC.		"euro sign"
	UnicodeCodePoints at: 16rA6+1 put: 16r160.		"latin capital letter S with caron"
	UnicodeCodePoints at: 16rA8+1 put: 16r161.		"latin small letter s with caron"
	UnicodeCodePoints at: 16rB4+1 put: 16r17D.		"latin capital letter Z with caron"
	UnicodeCodePoints at: 16rB8+1 put: 16r17E.		"latin small letter z with caron"
	UnicodeCodePoints at: 16rBC+1 put: 16r152.		"latin capital ligature OE"
	UnicodeCodePoints at: 16rBD+1 put: 16r153.		"latin small ligature oe"
	UnicodeCodePoints at: 16rBE+1 put: 16r178.		"latin capital letter Y with diaeresis"
	


Method Character class>>unicodeCodePoint:

    unicodeCodePoint: codePoint
	"
	Answer nil if the Unicode codePoint is not a valid ISO 8859-15 character
	
	self assert: (Character unicodeCodePoint: 16r41) = $A.
	self assert: (Character unicodeCodePoint: 16r20AC) = $€.
	"
	| code |
	code _ (UnicodeCodePoints indexOf: codePoint) -1.
	code = -1 ifTrue: [ ^nil ].
	^Character value: code


#### Class String

    ArrayedCollection variableByteSubclass: #String
	instanceVariableNames: ''
	classVariableNames: 'CSLineEnders CSNonSeparators CSSeparators CaseInsensitiveOrder
	                     CaseSensitiveOrder LowercasingTable Tokenish UppercasingTable'
	poolDictionaries: ''
	category: 'Kernel-Text'

Comment:
A String is an indexed collection of Characters, compactly encoded as 8-bit bytes.

String support a vast array of useful methods, which can best be learned by browsing and trying out 
examples as you find them in the code.

Here are a few useful methods to look at...
	String match:
	String contractTo:

String also inherits many useful methods from its hierarchy, such as
	SequenceableCollection ,
	SequenceableCollection copyReplaceAll:with:
	
	
Method String>>iso8859s15ToUtf8

	iso8859s15ToUtf8
	"Convert the given string to UTF-8 from the internal encoding: ISO Latin 9 (ISO 8859-15)"
	"
	self assert: ('A¢€' iso8859s15ToUtf8 asByteArray) hex = '41C2A2E282AC'
	"
	^String streamContents: [ :strm | | characters |
		characters _ self readStream.
		[ characters atEnd ] whileFalse: [
			Integer
				evaluate: [ :byte | strm nextPut: (Character value: byte) ]
				withUtf8BytesOfUnicodeCodePoint: characters next unicodeCodePoint ]]
	

#### Class Integer

Method Integer>>utf8BytesOfUnicodeCodePoint:

	utf8BytesOfUnicodeCodePoint: aCodePoint
	  "
	  self assert: (Integer utf8BytesOfUnicodeCodePoint: 16r0024) hex =  '24'.
	  self assert: (Integer utf8BytesOfUnicodeCodePoint: 16r00A2) hex =  'C2A2'.
	  self assert: (Integer utf8BytesOfUnicodeCodePoint: 16r20AC) hex = 'E282AC'.
	  self assert: (Integer utf8BytesOfUnicodeCodePoint: 16r024B62) hex = 'F0A4ADA2'.
	  "
	  ^ ByteArray streamContents: [ :strm |
		self
			evaluate: [ :byte |
				strm nextPut: byte ]
			withUtf8BytesOfUnicodeCodePoint: aCodePoint ].
			

Method Integer>>nextUnicodeCodePointFromUtf8:

    nextUnicodeCodePointFromUtf8: anUtf8Stream
	"
	anUtf8Stream can be over a ByteArray or a String
	Answer nil if conversion not possible

	| bytes string |
	bytes _ (ByteArray readHexFrom: 'C3A1C3A5C3A6C3B1C386C2A5C3BC') readStream.
	string _ String streamContents: [ :strm |
		[bytes atEnd ] whileFalse: [
			strm nextPut: (Character value: (Integer nextUnicodeCodePointFromUtf8: bytes )) ]].
	self assert: string = 'áåæñÆ¥ü'
	"
	| byte1 byte2 byte3 byte4 |
	byte1 _ anUtf8Stream next asInteger.
	byte1 < 128 ifTrue: [	"single byte"
		^byte1 ].
	
	"At least 2 bytes"
	byte2 _ anUtf8Stream next asInteger.
	(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rE0) = 192 ifTrue: [ "two bytes"
		^ ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63) ].
	
	"At least 3 bytes"
	byte3 _ anUtf8Stream next asInteger.
	(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rF0) = 224 ifTrue: [ "three bytes"
		^ ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6) + (byte3 bitAnd: 63) ].

	byte4 _ anUtf8Stream next asInteger.
	(byte4 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rF8) = 240 ifTrue: [  "four bytes"
		^ ((byte1 bitAnd: 16r7) bitShift: 18) +
                  ((byte2 bitAnd: 63) bitShift: 12) + ((byte3 bitAnd: 63) bitShift: 6) + (byte4 bitAnd: 63) ].

	^nil
	


### References

- http://www.unicode.org/versions/Unicode6.2.0/
- http://en.wikipedia.org/wiki/ISO/IEC_8859-15
- http://en.wikipedia.org/wiki/Plane_%28Unicode%29#Basic_Multilingual_Plane
