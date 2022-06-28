"
Presenter used to display the resolution of a dependency, i.e. display the dependency graph
"
Class {
	#name : #PBResolutionPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'resolutionTree'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBResolutionPresenter class >> conflictingResolutionExample [

	| registry |

	registry := PBPackageRegistry new.
	PharoLauncherProject buildAndRegisterIn: registry.
	registry register: ((PBProjectVersion named: 'OSSubprocess')
		version: '1.4';
		yourself).
	^ (registry projectNamed: #PharoLauncher) resolve
	
]

{ #category : #examples }
PBResolutionPresenter class >> example [
	<example>


	(self on: self conflictingResolutionExample) open
]

{ #category : #accessing }
PBResolutionPresenter >> conflictStatusIconFor: aResolvedItem [
	
	^ aResolvedItem conflictStatusIconName
		ifNotNil: [ :iconName | self iconNamed: iconName ]
]

{ #category : #layout }
PBResolutionPresenter >> defaultLayout [ 
	
	^ SpBoxLayout newTopToBottom 
		add: resolutionTree;
		add: (SpGridLayout build: [ : builder |
			builder
				beColumnNotHomogeneous;
				column: 2 withConstraints: [ :c | c beExpand ];
				add: (self iconNamed: PBResolvedProject new iconName);
				add: 'Resolved project';
				nextRow;
				add: (self iconNamed: PBResolvedDependency noConflictIconName);
				add: 'Resolved dependency';
				nextRow;
				add: (self iconNamed: PBResolvedDependency conflictIconName);
				add: 'Conflicting dependency' ]);
		yourself
]

{ #category : #initialization }
PBResolutionPresenter >> initializePresenters [

	resolutionTree := self newTreeTable
		roots: { self resolution };
		children: [ :project | project nodesInResolutionTree sorted: [ :a :b | a name < b name ] ];
		addColumn: (SpCompositeTableColumn
			with: (SpImageTableColumn evaluated: [ :resolvedItem | self conflictStatusIconFor: resolvedItem ])
			with: (SpImageTableColumn evaluated: [ :resolvedItem | self iconNamed: resolvedItem iconName ])
			with: (SpStringTableColumn evaluated: [ :resolvedItem | resolvedItem nameWithVersion ]) );
		contextMenu: (SpMenuPresenter new addGroup: [ :group | group 
			addItem: [ :item | item 
				name: 'Inspect'; 
				action: [ resolutionTree selectedItem inspect ] ] ]);
		expandRoots;
		yourself.

]

{ #category : #accessing }
PBResolutionPresenter >> resolution [
	^ self model
]

{ #category : #updating }
PBResolutionPresenter >> updateResolutionTree [
	
	resolutionTree updateRootsKeepingSelection: resolutionTree roots
]
