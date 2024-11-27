'From Cuis7.1 [latest update: #6843] on 27 November 2024 at 3:25:22 pm'!
'Description General classes to keep notes'!
!provides: 'AddOns-Notes' 1 6!
SystemOrganization addCategory: #'AddOns-Notes'!


!classDefinition: #MyNotes category: #'AddOns-Notes'!
SystemWindow subclass: #MyNotes
	instanceVariableNames: 'contentArea currentContentStringSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AddOns-Notes'!
!classDefinition: 'MyNotes class' category: #'AddOns-Notes'!
MyNotes class
	instanceVariableNames: ''!

!classDefinition: #MyNotesWithText category: #'AddOns-Notes'!
MyNotes subclass: #MyNotesWithText
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AddOns-Notes'!
!classDefinition: 'MyNotesWithText class' category: #'AddOns-Notes'!
MyNotesWithText class
	instanceVariableNames: ''!


!MyNotes commentStamp: 'hjh 11/27/2024 15:18:49' prior: 0!
Subclass of SystemWindows specialised to display notes.


    MyNotes open

The notes are saved in a method when you change tabs.
This class may be filed out and then renamed and then filed in again to get a different type of note class.
The class is stand-alone, that is it can be filed in in another Cuis image. This is a way to move notes from one image to another stored as code.!

!MyNotesWithText commentStamp: 'hjh 11/27/2024 15:24:41' prior: 0!
Comment see superclass


   MyNotesWithText open!

!MyNotes methodsFor: 'GUI building buttons' stamp: 'hjh 1/31/2013 13:15'!
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

!MyNotes methodsFor: 'GUI building buttons' stamp: 'hjh 11/27/2024 15:00:15'!
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

!MyNotes methodsFor: 'GUI building buttons' stamp: 'hjh 11/27/2024 15:21:32'!
defaultButtonWidth
	^100! !

!MyNotes methodsFor: 'GUI building' stamp: 'hjh 1/31/2013 12:35'!
buildMorphicWindow

self setLabel: self titleString.

contentArea := self textModelMorphforSelector:  #contentString1.
currentContentStringSelector := #contentString1.


self layoutMorph addMorph:  (self createButtonBarFromSpec: self customButtonSpecs) fixedHeight: 40.
self layoutMorph addMorphUseAll: contentArea.

self openInWorld

! !

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

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:52'!
contentString1
	^ 'This is the red content area.

   You may edit this text and 
   when you press another button it will be  saved.
'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:53'!
contentString2
	^ 'green

'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:54'!
contentString3
	^ 'blue'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:55'!
contentString4
	^ 'yellow


'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:56'!
contentString5
	^ 'This is the orange content area.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content' stamp: 'hjh 11/27/2024 15:21:08'!
contentString6
	^ 'This is the magenta content area.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content' stamp: 'hh 12/7/2013 22:52'!
contentString7
	^ 'This is the red content area 7.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content' stamp: 'hh 12/7/2013 22:52'!
contentString8
	^ 'This is the red content area 8.

   You may edit this text and 
   when you press another button it will be  saved.'! !

!MyNotes methodsFor: 'content manipulation' stamp: 'hjh 1/31/2013 09:29'!
display: aContentSelector

	currentContentStringSelector ifNotNil:  [self removeOldContent].
	
	currentContentStringSelector := aContentSelector.
	
	self layoutMorph addMorphUseAll: 
		(contentArea := self textModelMorphforSelector:  currentContentStringSelector)
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

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/31/2013 06:30'!
initialExtent
	
	
	^ 480 @ 360! !

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/12/2013 11:18'!
initialize

	super initialize.
	self buildMorphicWindow.! !

!MyNotes methodsFor: 'initialization' stamp: 'hjh 1/31/2013 10:43'!
titleString

	^ self className! !

!MyNotes class methodsFor: 'as yet unclassified' stamp: 'hjh 1/31/2013 14:13'!
open
	^self new openInWorld! !

!MyNotesWithText methodsFor: 'initialization' stamp: 'hjh 1/31/2013 18:03'!
initialExtent

^ 400 @ 500! !

!MyNotesWithText methodsFor: 'initialization' stamp: 'hjh 1/31/2013 18:03'!
titleString

	^ 'Notes with text'! !

!MyNotesWithText methodsFor: 'GUI building buttons' stamp: 'hjh 11/27/2024 15:02:14'!
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

!MyNotesWithText methodsFor: 'GUI building buttons' stamp: 'hjh 1/31/2013 18:02'!
defaultButtonWidth
	^48! !

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

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/27/2024 15:24:24'!
contentString1
	^ (Text string: 'This text may be styled. 
' runs: (RunArray runs: #(17 6 3) values: ((Array new: 3) at: 1 put: #(); at: 2 put: ((Array new: 1) at: 1 put: (TextEmphasis basicNew instVarAt: 1 put: 1; yourself); yourself); at: 3 put: #(); yourself)))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/27/2024 15:24:22'!
contentString2
	^ (Text string: '
' runs: (RunArray runs: #(1) values: #(#())))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/27/2024 15:23:36'!
contentString3
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/25/2024 13:05:31'!
contentString4
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/25/2024 13:05:08'!
contentString5
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/25/2024 13:05:06'!
contentString6
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/25/2024 13:05:05'!
contentString7
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText methodsFor: 'content' stamp: 'hjh 11/25/2024 13:05:04'!
contentString8
	^ (Text string: '' runs: (RunArray runs: #() values: #()))! !

!MyNotesWithText class methodsFor: 'as yet unclassified' stamp: 'hjh 2/19/2013 11:14'!
includeInNewMorphMenu
	^ true! !
