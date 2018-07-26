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
	
	self window close.
	
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
		elements: self conflicts;
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
	^ resolution 
]

{ #category : #accessing }
PBResolveConflictsDialog >> resolution: aResolution [
	resolution := aResolution
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
	
	^ (self conflicts anySatisfy: [ :each | each isResolved not ]) 
		ifTrue: [ self window toolbar okButton disable ]
		ifFalse: [ self window toolbar okButton enable ]
]
