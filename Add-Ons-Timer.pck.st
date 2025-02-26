'From Cuis 4.2 of 25 July 2013 [latest update: #1867] on 7 December 2013 at 10:34:04.510184 pm'!
'Description Pomodoro Timer : http://en.wikipedia.org/wiki/Pomodoro_Technique'!
!provides: 'Add-Ons-Timer' 1 1!
!classDefinition: #PomodoroTimer category: #'Add-Ons-Timer'!
SystemWindow subclass: #PomodoroTimer
	instanceVariableNames: 'minuteMorphs startTime titleString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Add-Ons-Timer'!
!classDefinition: 'PomodoroTimer class' category: #'Add-Ons-Timer'!
PomodoroTimer class
	instanceVariableNames: ''!


!PomodoroTimer commentStamp: 'hjh 3/5/2013 09:08' prior: 0!
Subclass of SystemWindow which demonstrates how to use #beRow to do a layout.

A timer is implemented. Evaluate:

     PomodoroTimer open

or

    PomodoroTimer openForTask: 'My task at hand'.


http://en.wikipedia.org/wiki/Pomodoro_Technique

The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s.[1] The technique uses a timer to break down periods of work into 25-minute intervals called 'Pomodori' (from the Italian word for 'tomatoes') separated by breaks. Closely related to concepts such as timeboxing and iterative and incremental development used in software design, the method has been adopted in pair programming contexts.[2] The method is based on the idea that frequent breaks can improve mental agility.[3][4]

There are five basic steps to implementing the technique:

1) decide on the task to be done
2) set the pomodoro (timer) to 25 minutes
3) work on the task until the timer rings; record with an x
4) take a short break (3-5 minutes)
5) every four "pomodori" take a longer break (15&#8211;30 minutes)
!

!PomodoroTimer methodsFor: 'GUI building' stamp: 'hh 12/7/2013 22:33'!
buildMorphicWindow


 
  self setLabel: self titleString.
  self layoutMorph beRow.
  25 timesRepeat: [ | circle | circle := (EllipseMorph new color: Color red muchLighter; 
	morphExtent: 20@20).
	minuteMorphs add: circle.
	self layoutMorph addMorph: circle].

  5 timesRepeat: [ | circle | circle := (EllipseMorph new color: Color blue muchLighter; 
	morphExtent: 20@20).
	minuteMorphs add: circle.
	self layoutMorph addMorph: circle].

 ! !

!PomodoroTimer methodsFor: 'GUI building' stamp: 'hh 12/7/2013 22:31'!
initialExtent
	
	
	^ 610 @ 20! !

!PomodoroTimer methodsFor: 'initialization' stamp: 'hjh 3/5/2013 08:51'!
initialize
	super initialize.
	
	minuteMorphs := OrderedCollection new.
	startTime := Time now.
	titleString := 'Timer 25 plus 5 minutes'.

	self buildMorphicWindow.! !

!PomodoroTimer methodsFor: 'GUI building' stamp: 'hh 12/7/2013 22:29'!
initializeLabelArea
	"Initialize the label area (titlebar) for the window.
	This is a shorter version of inherited #initializeLabelArea. Copied from superclass.
	We do not create the other controls"
 

	| topLeft spacing |
	topLeft := (self labelHeight + borderWidth - Theme current titleBarButtonsExtent / 2) ceiling asPoint.
	spacing := Theme current titleBarButtonsExtent x *13//10.
	self addMorph: self createCloseButton position: topLeft.
	"self addMorph: self createCollapseButton position: spacing@0 + topLeft.
	self addMorph: self createExpandButton position: spacing*2@0 + topLeft.
	self addMorph: self createMenuButton position: spacing*3@0 + topLeft"

 
! !

!PomodoroTimer methodsFor: 'updating' stamp: 'hjh 1/29/2013 21:49'!
step
	| currentColor currentMorph minutes |

	
	minutes := (Time now - startTime) minutes.
	minutes > 0 ifTrue: [
				currentMorph := minuteMorphs at:  minutes ifAbsent: [minuteMorphs last].
			
				currentColor := currentMorph color darker.
				minutes <= 25 ifTrue: [currentColor := Color red]. "set to red for the first 25"
				currentMorph color: currentColor
				]! !

!PomodoroTimer methodsFor: 'updating' stamp: 'hjh 1/29/2013 21:50'!
stepTime

	^5000! !

!PomodoroTimer methodsFor: 'accessing' stamp: 'hjh 3/5/2013 09:01'!
titleString
	
	^'Timer 25 plus 5 minutes'! !

!PomodoroTimer methodsFor: 'updating' stamp: 'hjh 1/29/2013 18:47'!
wantsSteps
	"Return true if the receiver wants to its #step or #stepAt: methods be run"

	^true! !

!PomodoroTimer class methodsFor: 'as yet unclassified' stamp: 'hjh 2/2/2013 04:19'!
open

	^self new openInWorld ! !

!PomodoroTimer class methodsFor: 'as yet unclassified' stamp: 'hjh 3/5/2013 09:07'!
openForTask: aString

	^ (self new setLabel: aString) openInWorld
! !
