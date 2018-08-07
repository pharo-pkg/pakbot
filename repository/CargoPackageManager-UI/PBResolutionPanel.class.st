"
Panel used to display the resolution of a dependency, i.e. display the dependency graph
"
Class {
	#name : #PBResolutionPanel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'resolutionTree',
		'resolution'
	],
	#category : #'CargoPackageManager-UI-Resolution'
}

{ #category : #specs }
PBResolutionPanel class >> defaultSpec [
	^ SpecLayout composed
		add: #resolutionTree;
		yourself
]

{ #category : #example }
PBResolutionPanel class >> example [
	<example>

	| resolution |

	resolution := (CGOPackageRegistry default projectNamed: #PharoLauncher) resolve.
	(self on: resolution) openWithSpec
]

{ #category : #initialization }
PBResolutionPanel >> doExpandNodesWithConflicts: aCollection [ 
	
	aCollection do: [ :aNode |
			aNode data hasToBeExpanded ifTrue: [ aNode expand ].
			self doExpandNodesWithConflicts: aNode children ]
]

{ #category : #initialization }
PBResolutionPanel >> expandNodesWithConflicts [
	
	self doExpandNodesWithConflicts: resolutionTree widget dataSource rootItem children

]

{ #category : #initialization }
PBResolutionPanel >> initializeWidgets [
	
	resolutionTree := self newFastTreeTable.
	
	resolutionTree widget dataSource: self resolutionDataSource.
	self expandNodesWithConflicts	
]

{ #category : #initialization }
PBResolutionPanel >> resolutionDataSource [
	| datasource |
	datasource := PBResolutionDataSource
		roots: {resolution}
		children: [ :project | project nodesInResolutionTree sorted: [ :a :b | a name < b name ] ].
		
	^ datasource
]

{ #category : #accessing }
PBResolutionPanel >> resolutionTree [
	^ resolutionTree 
]

{ #category : #'model access' }
PBResolutionPanel >> setModelBeforeInitialization: aModel [

	resolution := aModel
]

{ #category : #updating }
PBResolutionPanel >> updateResolutionTree [
	
	resolutionTree widget dataSource updateData.
	self expandNodesWithConflicts
]
