Class {
	#name : #PBConflictsColumn,
	#superclass : #FTColumn,
	#instVars : [
		'selector'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #'instance creation' }
PBConflictsColumn class >> header: aHeaderString selector: anAccessorSelector [

	^ (self id: aHeaderString)
		selector: anAccessorSelector;
		yourself
]

{ #category : #reading }
PBConflictsColumn >> header [
	^ SimpleButtonMorph new
		layoutPolicy: RowLayout new;
		listDirection: #leftToRight;
		wrapCentering: #center;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellInset: 5 @ 0;
		layoutInset: 5 @ 0;
		label: self id;
		yourself
]

{ #category : #reading }
PBConflictsColumn >> read: aPBConflict [
	^ (selector value: aPBConflict) asString asMorph
]

{ #category : #accessing }
PBConflictsColumn >> selector: aString [ 
	selector := aString
]
