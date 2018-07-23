Class {
	#name : #PBResolveConflictsDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'conflicts',
		'errorToResume',
		'toolbar',
		'conflictsList'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #specs }
PBResolveConflictsDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #toolbar height: ITToolBar defaultHeight;
				newRow: #conflictsList ]
]

{ #category : #specs }
PBResolveConflictsDialog class >> on: aConflictException [

	^ self basicNew
		errorToResume: aConflictException;
		conflicts: aConflictException resolution conflicts;
		initialize;
		yourself
]

{ #category : #actions }
PBResolveConflictsDialog >> accept [
	
	self window close.
	
	conflicts do: [:aConflict | aConflict resolveWithSelected].
	errorToResume resume
]

{ #category : #accessing }
PBResolveConflictsDialog >> conflicts: aCollection [ 
	conflicts := aCollection
]

{ #category : #accessing }
PBResolveConflictsDialog >> conflictsList [
	^ conflictsList
]

{ #category : #accessing }
PBResolveConflictsDialog >> errorToResume: aPBProjectHasConflictsError [ 
	errorToResume := aPBProjectHasConflictsError 
]

{ #category : #api }
PBResolveConflictsDialog >> initialExtent [
	^ 600@450
]

{ #category : #initialization }
PBResolveConflictsDialog >> initializeWidgets [
	
	toolbar := self instantiate: ITToolBar.
	conflictsList := self newFastTable.
	
	conflictsList widget 
		addColumn: (PBConflictsColumn header:'Project Name' selector: #projectName);
		addColumn: ((PBDropDownColumn id:'Version to Use') dialog: self; yourself);
		addColumn: (PBNullColumn id: '');
		dataSource: self newConflictDataSource;
		showColumnHeaders.
		
	self whenWindowChanged: [ self updateOkButton ].

]

{ #category : #initialization }
PBResolveConflictsDialog >> newConflictDataSource [

	^ PBConflictsDataSource new 
		elements: conflicts;
		yourself
]

{ #category : #api }
PBResolveConflictsDialog >> openDialogWithSpec [

	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBResolveConflictsDialog >> resolution [
	^ errorToResume resolution 
]

{ #category : #api }
PBResolveConflictsDialog >> title [
	^ 'Resolve Conflicts for Project ' , self resolution resolvedProjectVersion name
]

{ #category : #accessing }
PBResolveConflictsDialog >> toolbar [
	^ toolbar
]

{ #category : #updating }
PBResolveConflictsDialog >> updateOkButton [
	
	^ (conflicts anySatisfy: [ :each | each isResolved not ]) 
		ifTrue: [ self window toolbar okButton disable ]
		ifFalse: [ self window toolbar okButton enable ]
]
