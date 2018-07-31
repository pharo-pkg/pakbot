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
PBResolutionPanel >> initializeWidgets [
	
	resolutionTree := self newFastTreeTable.
	
	resolutionTree widget 
		dataSource: self resolutionDataSource.
		
]

{ #category : #initialization }
PBResolutionPanel >> resolutionDataSource [
	| datasource |
	datasource := PBResolutionDataSource
		roots: {resolution}
		children: [ :project | project subresolutions sorted: [ :a :b | a name < b name ] ].
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
	
	resolutionTree widget dataSource updateData
]
