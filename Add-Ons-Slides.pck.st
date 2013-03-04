'From Cuis 4.1 of 12 December 2012 [latest update: #1616] on 4 March 2013 at 10:36:37 am'!
'Description Morphs to display different slides. See also Add-Ons-LayoutDemo.'!
!classDefinition: #ABCbook category: #'Add-Ons-Slides'!
SystemWindow subclass: #ABCbook
	instanceVariableNames: 'contentArea'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Add-Ons-Slides'!
!classDefinition: 'ABCbook class' category: #'Add-Ons-Slides'!
ABCbook class
	instanceVariableNames: ''!

!classDefinition: #ABCbook2 category: #'Add-Ons-Slides'!
ABCbook subclass: #ABCbook2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Add-Ons-Slides'!
!classDefinition: 'ABCbook2 class' category: #'Add-Ons-Slides'!
ABCbook2 class
	instanceVariableNames: ''!


!ABCbook commentStamp: '<historical>' prior: 0!
Subclass of SystemWindows specialised to display layout examples
Based on LayoutDemo6b from 'Add-Ons-LayoutDemo'

In #addPageTo: name: a LayoutMorph is used.

       ABCbook open


Needs class  ContentPack2ABC 



!

!ABCbook2 commentStamp: 'hjh 3/4/2013 09:47' prior: 0!
Subclass of ABCbook; different font size for buttons

    ABCbook2 open!

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:17'!
addButtonTo: aMorph name: aName
| aSymbol |


aSymbol := aName asSymbol.

aMorph addMorph: (PluggableButtonMorph 
			model: [ self bringPageToFront: aSymbol] action: #value label: aName) 
	            fixedWidth: 70! !

!ABCbook methodsFor: 'pages' stamp: 'hjh 3/4/2013 10:34'!
addPageTo: contentArea name: aKey

	|  img aSymbol |
	
	aSymbol := aKey asSymbol.

	img := ImageMorph new image: 
		((Smalltalk at: #ContentPack2ABC) current  at: aKey).

      contentArea addMorph: (LayoutMorph newColumn 
								setProperty: #name toValue: aSymbol;
								color:  self class defaultBackgroundColor;
								addMorph: img;
								morphExtent: 500@350
							).
								! !

!ABCbook methodsFor: 'pages' stamp: 'hjh 1/31/2013 05:20'!
bringPageToFront: aPageName

 	| page |
	
	page := contentArea submorphs detect: [ :morph | (morph valueOfProperty: #name) = aPageName].
	
	contentArea addMorphFront: page. 
	


! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:54'!
buildMorphicWindow

self setLabel: self titleString.


self layoutMorph addMorph:  self createButtonBar fixedHeight: 40.
self layoutMorph addMorph:  self createButtonBar2 fixedHeight: 40.
self layoutMorph addMorph:  self createButtonBar3 fixedHeight: 40.
self layoutMorph addMorph:  self createButtonBar4 fixedHeight: 40.
self layoutMorph addMorph:  self createButtonBar5 fixedHeight: 40.


self layoutMorph addMorphUseAll: self makeContentArea.

self bringPageToFront: #Apple.

self openInWorld.

! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:27'!
createButtonBar
 | bar |

	bar := LayoutMorph newRow. 

 	self addButtonTo: bar  name: 'Apple'. 
	self addButtonTo: bar  name: 'Ball'. 
 	self addButtonTo: bar  name: 'Cat'. 
 	self addButtonTo: bar  name: 'Duck'. 
 	self addButtonTo: bar  name: 'Elephant'. 
 	
	
	^bar
	
! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:29'!
createButtonBar2
 | bar |

	bar := LayoutMorph newRow. 

 	self addButtonTo: bar  name: 'Fish'. 
 	self addButtonTo: bar  name: 'Gate'. 
	self addButtonTo: bar  name: 'Horse'. 
	self addButtonTo: bar  name: 'Igloo'. 
	self addButtonTo: bar  name: 'Jam'. 
 	
	
	^bar
	
! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:33'!
createButtonBar3
 | bar |

	bar := LayoutMorph newRow. 

 	self addButtonTo: bar  name: 'Kangaroo'. 
 	self addButtonTo: bar  name: 'Lion'. 
	self addButtonTo: bar  name: 'Mouse'. 
	self addButtonTo: bar  name: 'Nest'. 
	self addButtonTo: bar  name: 'Octopus'. 
 	
	
	^bar
	
! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:50'!
createButtonBar4
 | bar |

	bar := LayoutMorph newRow. 

 	self addButtonTo: bar  name: 'Pig'. 
 	self addButtonTo: bar  name: 'Queen'. 
	self addButtonTo: bar  name: 'Road'. 
	self addButtonTo: bar  name: 'Sun'. 
	self addButtonTo: bar  name: 'Turtle'. 
	
	
	^bar
	
! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 2/10/2013 18:54'!
createButtonBar5
 | bar |

	bar := LayoutMorph newRow. 

 	self addButtonTo: bar  name: 'Umbrella'. 
 	self addButtonTo: bar  name: 'Volcano'. 
	self addButtonTo: bar  name: 'Window'. 
	self addButtonTo: bar  name: 'Xylophon'. 
	self addButtonTo: bar  name: 'Yo-yo'. 
	self addButtonTo: bar  name: 'Zebra'. 
	
	^bar
	
! !

!ABCbook methodsFor: 'initialization' stamp: 'hjh 2/10/2013 18:55'!
initialExtent
	
	
	^ 500 @ 600! !

!ABCbook methodsFor: 'initialization' stamp: 'hjh 1/12/2013 11:18'!
initialize

	super initialize.
	self buildMorphicWindow.! !

!ABCbook methodsFor: 'GUI building' stamp: 'hjh 1/12/2013 11:21'!
initializeLabelArea
	"Initialize the label area (titlebar) for the window.
	This is a shorter version of inherited #initializeLabelArea.
	We do not create the other controls"

	|  box |

	box _ self createCloseBox.
	self addMorph: box.
	box morphPosition: 2@2.
	box morphExtent: self boxExtent.

! !

!ABCbook methodsFor: 'pages' stamp: 'hjh 2/10/2013 18:54'!
makeContentArea
	"ABC"
 	contentArea := RectangleLikeMorph new color: Color gray.  "This morph does not do layout control"

	"morphs are added on top of each other"

      self addPageTo: contentArea name: 'Apple'.
      self addPageTo: contentArea name: 'Ball'.
      self addPageTo: contentArea name: 'Cat'.
      self addPageTo: contentArea name: 'Duck'.
	self addPageTo: contentArea name: 'Elephant'.

	self addPageTo: contentArea name: 'Fish'.
	self addPageTo: contentArea name: 'Gate'.							
	self addPageTo: contentArea name: 'Horse'.	
	self addPageTo: contentArea name: 'Igloo'.
	self addPageTo: contentArea name: 'Jam'.	

	self addPageTo: contentArea name: 'Kangaroo'.	
	self addPageTo: contentArea name: 'Lion'.	
	self addPageTo: contentArea name: 'Mouse'.	
	self addPageTo: contentArea name: 'Nest'.	
	self addPageTo: contentArea name: 'Octopus'.	
	
	self addPageTo: contentArea name: 'Pig'.	
	self addPageTo: contentArea name: 'Queen'.	
	self addPageTo: contentArea name: 'Road'.	
	self addPageTo: contentArea name: 'Sun'.	
	self addPageTo: contentArea name: 'Turtle'.	
	
	self addPageTo: contentArea name: 'Pig'.	
	self addPageTo: contentArea name: 'Queen'.	
	self addPageTo: contentArea name: 'Road'.	
	self addPageTo: contentArea name: 'Sun'.	
	self addPageTo: contentArea name: 'Turtle'.	
	
	self addPageTo: contentArea name: 'Umbrella'.	
	self addPageTo: contentArea name: 'Volcano'.	
	self addPageTo: contentArea name: 'Window'.	
	self addPageTo: contentArea name: 'Xylophon'.	
	self addPageTo: contentArea name: 'Yo-yo'.	
	self addPageTo: contentArea name: 'Zebra'.	

	^ contentArea


    ! !

!ABCbook methodsFor: 'initialization' stamp: 'hjh 2/10/2013 18:26'!
titleString

	^'ABC book' ! !

!ABCbook class methodsFor: 'as yet unclassified' stamp: 'hjh 2/11/2013 09:36'!
checkIfABCdictionaryWithPicturesPresent

	(Smalltalk at: #ContentPack2ABC ifAbsent: []) isNil
		ifTrue: [self inform: 'You need to have loaded ''ContentPack2ABC'' from https://github.com/hhzl/ContentPack.' . ^false].
		
	^true	! !

!ABCbook class methodsFor: 'as yet unclassified' stamp: 'hjh 2/11/2013 09:19'!
defaultBackgroundColor

	^Color blue! !

!ABCbook class methodsFor: 'as yet unclassified' stamp: 'hjh 2/11/2013 09:35'!
open

	self checkIfABCdictionaryWithPicturesPresent
	
	    ifTrue:  [^self new openInWorld]! !

!ABCbook2 methodsFor: 'as yet unclassified' stamp: 'hjh 2/11/2013 07:43'!
addButtonTo: aMorph name: aName
| aSymbol button |


aSymbol := aName asSymbol.

button := PluggableButtonMorph 
			               model: [ self bringPageToFront: aSymbol]
			               action: #value.
			 
button label: aName first asString font: (
	AbstractFont familyName: 'DejaVu' pointSize: 17
     ).

aMorph addMorph: button fixedWidth: 70! !

!ABCbook2 class methodsFor: 'as yet unclassified' stamp: 'hjh 2/11/2013 09:20'!
defaultBackgroundColor

	^Color green darker darker! !
