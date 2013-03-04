'From Cuis 4.1 of 12 December 2012 [latest update: #1616] on 4 March 2013 at 10:45:34 am'!
'Description General classes to keep notes'!
!classDefinition: #MyNotes category: #'Add-Ons-Notes'!
SystemWindow subclass: #MyNotes
	instanceVariableNames: 'contentArea currentContentStringSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Add-Ons-Notes'!
!classDefinition: 'MyNotes class' category: #'Add-Ons-Notes'!
MyNotes class
	instanceVariableNames: ''!

!classDefinition: #MyNotesWithText category: #'Add-Ons-Notes'!
MyNotes subclass: #MyNotesWithText
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Add-Ons-Notes'!
!classDefinition: 'MyNotesWithText class' category: #'Add-Ons-Notes'!
MyNotesWithText class
	instanceVariableNames: ''!


!MyNotes commentStamp: '<historical>' prior: 0!
Subclass of SystemWindows specialised to display notes.

A TextModelMorph as the content. 

Changed the behaviour of the buttons to change the text and automatically save the string in methods.


    MyNotes open!

!MyNotesWithText commentStamp: 'hjh 1/31/2013 18:05' prior: 0!
Example of configuration of MyNotes.


   stored are instances of Text and not just strings.

   MyNotesWithText open!

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 12:35'!
buildMorphicWindow

self setLabel: self titleString.

contentArea := self textModelMorphforSelector:  #contentString1.
currentContentStringSelector := #contentString1.


self layoutMorph addMorph:  (self createButtonBarFromSpec: self customButtonSpecs) fixedHeight: 40.
self layoutMorph addMorphUseAll: contentArea.

self openInWorld

! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:41'!
contentString1
	^ 'This is the red content area.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:42'!
contentString2
	^ 'green'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:42'!
contentString3
	^ 'blue'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:42'!
contentString4
	^ 'yellow'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:42'!
contentString5
	^ 'This is the red content area.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 1/31/2013 12:42'!
contentString6
	^ 'This is the red content area.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 13:15'!
createButtonBarFromSpec: aButtonCollectionSpec

| bar |

bar :=LayoutMorph newRow color: Color red.

aButtonCollectionSpec do: [ :buttonSpec |
    bar addMorph: 
        (PluggableButtonMorph 
			model: [ self display: (buttonSpec at: 2).
				        bar color: (Color perform: (buttonSpec at: 3))] 
			action: #value label: (buttonSpec at: 1)
	  ) 
    fixedWidth: self defaultButtonWidth].

^ bar! !

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 12:41'!
customButtonSpecs
	"Answer an array of elements of the label, selector and color"

	^#(
		('red'			#contentString1			     #lightRed)
		('green'			#contentString2			     #lightGreen)
		('blue'			#contentString3			     #lightBlue)
		('yellow'		#contentString4		           #yellow)
		('orange'		#contentString5		           #orange)
		('magenta'		#contentString6		           #magenta)
	)

  
! !

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 13:16'!
defaultButtonWidth
	^70! !

!MyNotes methodsFor: 'content manipulation' stamp: 'hjh 1/31/2013 09:29'!
display: aContentSelector

	currentContentStringSelector ifNotNil:  [self removeOldContent].
	
	currentContentStringSelector := aContentSelector.
	
	self layoutMorph addMorphUseAll: 
		(contentArea := self textModelMorphforSelector:  currentContentStringSelector)
	! !

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/31/2013 06:30'!
initialExtent
	
	
	^ 480 @ 360! !

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/12/2013 11:18'!
initialize

	super initialize.
	self buildMorphicWindow.! !

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 17:04'!
initializeLabelArea0
	"DEACTIVATED BY RENAMING Initialize the label area (titlebar) for the window.
	This is a shorter version of inherited #initializeLabelArea.
	We do not create the other controls"

	|  box |

	box _ self createCloseBox.
	self addMorph: box.
	box morphPosition: 2@2.
	box morphExtent: self boxExtent.

! !

!MyNotes methodsFor: 'content manipulation' stamp: 'hjh 1/31/2013 09:35'!
removeOldContent
"save the old content in a method first and then remove the text morph"

  | methodSource |

  methodSource :=

		 	currentContentStringSelector asString
			
			, String newLineString 
			
			,'	^ ''' ,
			
			contentArea model actualContents asString,
			
			''''.
   self class compile: methodSource.
			
   self layoutMorph removeMorph: contentArea.! !

!MyNotes methodsFor: 'content manipulation' stamp: 'hjh 1/31/2013 08:37'!
textModelMorphforSelector: aContentSelector

	^TextModelMorph withText: (self perform: aContentSelector)
	! !

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/31/2013 10:43'!
titleString

	^ self className! !

!MyNotes class methodsFor: 'as yet unclassified' stamp: 'hjh 1/31/2013 14:13'!
open
	^self new openInWorld! !

!MyNotesWithText methodsFor: 'configuration' stamp: 'hjh 1/31/2013 18:02'!
customButtonSpecs
	"Answer an array of elements of the label, selector and color"

	^#(
		('1'			#contentString1			     #lightRed)
		('2'			#contentString2			     #lightGreen)
		('3'			#contentString3			     #lightBlue)
		('4'		      #contentString4		           #yellow)
		('5'		      #contentString5		           #orange)
		('6'		      #contentString6		           #magenta)
		('7'		      #contentString7		           #brown)
		('8'		      #contentString8		           #tan)
	)

  ! !

!MyNotesWithText methodsFor: 'configuration' stamp: 'hjh 1/31/2013 18:02'!
defaultButtonWidth
	^48! !

!MyNotesWithText methodsFor: 'configuration' stamp: 'hjh 1/31/2013 18:03'!
initialExtent

^ 400 @ 500! !

!MyNotesWithText methodsFor: 'content manipulation' stamp: 'hjh 1/31/2013 18:01'!
removeOldContent
"save the old content in a method first and then remove the text morph"

  | methodSource |

  methodSource :=

		 	currentContentStringSelector asString
			
			, String newLineString 
			
			,'	^ ' ,
			
			contentArea model actualContents storeString.
			
   self class compile: methodSource.
			
   self layoutMorph removeMorph: contentArea.! !

!MyNotesWithText methodsFor: 'configuration' stamp: 'hjh 1/31/2013 18:03'!
titleString

	^ 'Notes with text'! !

!MyNotesWithText class methodsFor: 'as yet unclassified' stamp: 'hjh 2/19/2013 11:14'!
includeInNewMorphMenu
	^ true! !
