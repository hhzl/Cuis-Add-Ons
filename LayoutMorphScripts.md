# Gallery
Prerequisite before the following script may be executed. Needs at least Cuis 7-7061
````Smalltalk
Feature require: 'Graphics-Files-Additional'.
````

````Smalltalk

"(ImageReadWriter formFromFileNamed: 'F05.jpg') class  Form ."

row1 := LayoutMorph newRow.
row1 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F05e.jpg')).
row1 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F06e.jpg')).
row1 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F07b-e.jpg')).
row1 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F08e.jpg')).
row2 := LayoutMorph newRow.
row2 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F09e.jpg')).
row2 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F10e.jpg')).
row2 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F11e.jpg')).
row2 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F12e.jpg')). 
row3 := LayoutMorph newRow.
row3 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F13e.jpg')).
row3 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F14e.jpg')).
row3 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F15e.jpg')).
row3 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F16e.jpg')). 
row4 := LayoutMorph newRow.
row4 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F17e.jpg')).
row4 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F18e.jpg')).
row4 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F19e.jpg')).
row4 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F20e.jpg')). 
row5 := LayoutMorph newRow.
row5 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F21e.jpg')).
row5 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F22e.jpg')).
row5 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F23e.jpg')).
row5 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F24e.jpg')). 
row6 := LayoutMorph newRow.
row6 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F25e.jpg')).
row6 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F26e.jpg')).
row6 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F27e.jpg')).
row6 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F28e.jpg')). 
row7 := LayoutMorph newRow.
row7 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F29e.jpg')).
row7 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F30e.jpg')).
row7 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F31e.jpg')).
row7 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F32e.jpg')). 
row8 := LayoutMorph newRow.
row8 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F33e.jpg')).
row8 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F34e.jpg')).
row8 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F35e.jpg')).
row8 addMorphUseAll: (ImageMorph newWith: (ImageReadWriter formFromFileNamed: 'F36e.jpg')). 

col := LayoutMorph newColumn.
col addMorph: (LabelMorph contents: 'Gallery' font: (FontFamily defaultFamilyPointSize: 120)). 
col addMorph: row1.
col addMorph: row2.
col addMorph: row3.
col addMorph: row4.
col addMorph: row5.
col addMorph: row6.
col addMorph: row7.
col addMorph: row8.

JPEGReadWriter2 putForm: col imageForm quality: 100 progressiveJPEG: true onFileNamed: 'col.jpg'.
col morphExtent        


"(TextParagraphMorph contents: Utilities defaultTextEditorContents) openInWorld."
"InnerTextMorphs"
````


# Alphabet
````Smalltalk
column := LayoutMorph newColumn color: Color white.

columnWidth := 480. 
titleFontSize := 24. 
textFontSize := FontFamily defaultPointSize * 3.

column addMorph: (LabelMorph contents: 'Alphabet' font: (FontFamily defaultFamilyPointSize: titleFontSize)).

alphabet := TextParagraphMorph contents: ('Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm Nn Oo Pp Qq Rr Ss Tt Uu Vv Ww Xx Yy Zz' centered blue pointSize: textFontSize).
alphabet color: Color white.
alphabet borderWidth: 0.
alphabet morphExtent: columnWidth@230.
column addMorph: alphabet.

column addMorph: (LabelMorph contents: 'Vowels' font: (FontFamily defaultFamilyPointSize: titleFontSize)).

vowels := TextParagraphMorph contents: ('Aa Ee Ii Oo Uu' centered red pointSize: textFontSize).
vowels color: Color white.
vowels borderWidth: 0.
vowels morphExtent: columnWidth@100.
column addMorph: vowels.

column addMorph: (LabelMorph contents: 'Consonants' font: (FontFamily defaultFamilyPointSize: titleFontSize)).

consonants := TextParagraphMorph contents: ('Bb Cc Dd Ff Gg Hh Jj Kk Ll Mm Nn Pp Qq Rr Ss Tt Vv Ww Xx Yy Zz' centered black pointSize: textFontSize).
consonants color: Color white.
consonants borderWidth: 0.
consonants morphExtent: columnWidth@200.
column addMorph: consonants.

column layoutSubmorphs.
column openInHand

````
