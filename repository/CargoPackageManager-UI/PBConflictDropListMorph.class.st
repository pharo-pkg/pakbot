Class {
	#name : #PBConflictDropListMorph,
	#superclass : #DropListMorph,
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #private }
PBConflictDropListMorph >> listHeight [
	
	^ super listHeight max: 50
]
