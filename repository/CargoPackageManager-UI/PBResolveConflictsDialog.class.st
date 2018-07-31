Class {
	#name : #PBResolveConflictsDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'errorToResume',
		'toolbar',
		'conflictsList',
		'resolution'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #specs }
PBResolveConflictsDialog class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		add: #conflictsList;
		yourself
]

{ #category : #specs }
PBResolveConflictsDialog class >> example [
	<example>

	| resolution |

	resolution := (CGOPackageRegistry default projectNamed: #PharoLauncher) resolve.
	(self onResolution: resolution) openDialogWithSpec
]

{ #category : #specs }
PBResolveConflictsDialog class >> on: aConflictException [

	^ self basicNew
		errorToResume: aConflictException;
		resolution: aConflictException resolution;
		initialize;
		yourself
]

{ #category : #specs }
PBResolveConflictsDialog class >> onResolution: aResolution [

	^ self basicNew
		resolution: aResolution;
		initialize;
		yourself
]

{ #category : #specs }
PBResolveConflictsDialog class >> specWithToolbar [
	<spec: #withToolbar>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #toolbar height: ITToolBar defaultHeight;
				newRow: #conflictsList ]
]

{ #category : #actions }
PBResolveConflictsDialog >> accept [
	
	self conflicts do: [:aConflict | aConflict resolveWithSelected].
	errorToResume ifNotNil: [ errorToResume resume ]
]

{ #category : #accessing }
PBResolveConflictsDialog >> conflicts [
	^ resolution conflicts
]

{ #category : #accessing }
PBResolveConflictsDialog >> conflictsList [
	^ conflictsList
]

{ #category : #accessing }
PBResolveConflictsDialog >> errorToResume: aPBProjectHasConflictsError [ 
	errorToResume := aPBProjectHasConflictsError 
]

{ #category : #updating }
PBResolveConflictsDialog >> hasConflicts [
	^ self conflicts anySatisfy: [ :each | each isResolved not ]
]

{ #category : #initialization }
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
		addColumn: ((PBConflictDetailsColumn id:'Details'));
		addColumn: (PBNullColumn id: '');
		dataSource: self newConflictDataSource;
		showColumnHeaders.
		
	self whenWindowChanged: [ self updateOkButton ].

]

{ #category : #initialization }
PBResolveConflictsDialog >> newConflictDataSource [

	^ PBConflictsDataSource new 
		elements: self conflicts;
		yourself
]

{ #category : #opening }
PBResolveConflictsDialog >> openDialogWithSpec [

	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBResolveConflictsDialog >> resolution [
	^ resolution 
]

{ #category : #accessing }
PBResolveConflictsDialog >> resolution: aResolution [
	resolution := aResolution
]

{ #category : #accessing }
PBResolveConflictsDialog >> title [
	^ 'Resolve Conflicts for Project ' , self resolution resolvedProjectVersion name
]

{ #category : #accessing }
PBResolveConflictsDialog >> toolbar [
	^ toolbar
]

{ #category : #updating }
PBResolveConflictsDialog >> updateOkButton [
	^ self hasConflicts
		ifTrue: [ self window toolbar okButton disable ]
		ifFalse: [ self window toolbar okButton enable ]
]

{ #category : #actions }
PBResolveConflictsDialog >> updateTable [
	conflictsList widget refresh.

]
