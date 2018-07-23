Class {
	#name : #PBConflictsDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #actions }
PBConflictsDataSource >> actionColumn: aColumn [ 
]

{ #category : #accessing }
PBConflictsDataSource >> cellColumn: column row: rowIndex [ 

	^ FTCellMorph new
		addMorph: (column read: (self elementAt: rowIndex));
		yourself
	
]

{ #category : #accessing }
PBConflictsDataSource >> headerColumn: column [
	column id ifNil: [ ^ nil ].

	^ column header
		target: self;
		actionSelector: #actionColumn:;
		arguments: {self};
		yourself
]
