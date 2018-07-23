Class {
	#name : #PBNullColumn,
	#superclass : #PBConflictsColumn,
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #reading }
PBNullColumn >> header [
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

{ #category : #'meta-object-protocol' }
PBNullColumn >> read: anObject [

	^ '' asMorph
]

{ #category : #'meta-object-protocol' }
PBNullColumn >> width [
	^ 1
]
