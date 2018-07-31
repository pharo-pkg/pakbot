Class {
	#name : #PBResolveConflictsPanel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'toolbar',
		'conflictsList',
		'resolution',
		'conflicts'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #specs }
PBResolveConflictsPanel class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed 
		add: #conflictsList;
		yourself
]

{ #category : #specs }
PBResolveConflictsPanel class >> onResolution: aResolution owner: anOwner [

	^ self basicNew
		resolution: aResolution;
		owner: anOwner;
		initialize;
		yourself
]

{ #category : #specs }
PBResolveConflictsPanel class >> specWithToolbar [
	<spec: #withToolbar>
	
	^ SpecLayout composed 
		newColumn: [ :column |
			column 
				newRow: #toolbar height: ITToolBar defaultHeight;
				newRow: #conflictsList ]
]

{ #category : #actions }
PBResolveConflictsPanel >> accept [
	
	self conflicts do: [:aConflict | aConflict resolveWithSelected].

]

{ #category : #accessing }
PBResolveConflictsPanel >> conflicts [
	^ conflicts
]

{ #category : #accessing }
PBResolveConflictsPanel >> conflictsList [
	^ conflictsList
]

{ #category : #updating }
PBResolveConflictsPanel >> hasConflicts [
	^ self conflicts anySatisfy: [ :each | each isResolved not ]
]

{ #category : #initialization }
PBResolveConflictsPanel >> initialExtent [
	^ 600@450
]

{ #category : #initialization }
PBResolveConflictsPanel >> initializeWidgets [
	
	toolbar := self instantiate: ITToolBar.
	conflicts := resolution conflicts.
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
PBResolveConflictsPanel >> newConflictDataSource [

	^ PBConflictsDataSource new 
		elements: self conflicts;
		yourself
]

{ #category : #opening }
PBResolveConflictsPanel >> openDialogWithSpec [

	^ super openDialogWithSpec
		okAction: [ self accept ];
		yourself
]

{ #category : #accessing }
PBResolveConflictsPanel >> resolution [
	^ resolution 
]

{ #category : #accessing }
PBResolveConflictsPanel >> resolution: aResolution [
	resolution := aResolution
]

{ #category : #accessing }
PBResolveConflictsPanel >> title [
	^ 'Resolve Conflicts for Project ' , self resolution resolvedProjectVersion name
]

{ #category : #accessing }
PBResolveConflictsPanel >> toolbar [
	^ toolbar
]

{ #category : #updating }
PBResolveConflictsPanel >> updateOkButton [
	
	self conflicts do: #resolveWithSelected.
	self owner ifNotNil: [ self owner updateOkButton; updateResolutionTable ]
	
]

{ #category : #actions }
PBResolveConflictsPanel >> updateTable [
	conflictsList widget refresh.

]
