Class {
	#name : #PBConflictDropModel,
	#superclass : #Object,
	#instVars : [
		'conflict',
		'list',
		'dialog'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #'instance creation' }
PBConflictDropModel class >> on: aPBConflict dialog: dialog [
	^ self new
		conflict: aPBConflict;
		dialog: dialog
		yourself
]

{ #category : #accessing }
PBConflictDropModel >> conflict: aPBConflict [ 
	
	conflict := aPBConflict
]

{ #category : #accessing }
PBConflictDropModel >> dialog: aPBResolveConflictsDialog [ 
	dialog := aPBResolveConflictsDialog
]

{ #category : #accesing }
PBConflictDropModel >> list [
	
	list ifNil: [ list := conflict possibleResolutions ].
	^ list collect: [ :e | e version ]	


]

{ #category : #accessing }
PBConflictDropModel >> selected [
	
	^ conflict selectedResolution ifNotNil: #version
]

{ #category : #accessing }
PBConflictDropModel >> selected: aString [ 
	
	conflict selectedResolution: (list detect: [ :each | each version = aString ]).
	dialog updateTable.
	dialog updateOkButton.
]
