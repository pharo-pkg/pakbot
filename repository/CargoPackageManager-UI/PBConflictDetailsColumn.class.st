Class {
	#name : #PBConflictDetailsColumn,
	#superclass : #PBConflictsColumn,
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #reading }
PBConflictDetailsColumn >> read: aPBConflict [

	^ aPBConflict resolutionDetailText asMorph
]
