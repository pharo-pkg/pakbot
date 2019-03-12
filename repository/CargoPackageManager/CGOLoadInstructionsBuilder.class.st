"
Sort dependencies from leafs to the root.
"
Class {
	#name : #CGOLoadInstructionsBuilder,
	#superclass : #Object,
	#instVars : [
		'graph',
		'resolution',
		'loadInstructions'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #'loading order' }
CGOLoadInstructionsBuilder >> addLoadGroupFor: resolvedDependencies [
	| packageVersions |

	packageVersions := ( resolvedDependencies
		collect: [ :each | each resolution]
		thenReject: [ :each | each isInstalled ] ) asArray.
	packageVersions 
		ifNotEmpty: [ loadInstructions addGroup: (PBLoadGroup newWithAll: packageVersions) ]
]

{ #category : #'loading order' }
CGOLoadInstructionsBuilder >> loadInstructions [
	loadInstructions := CGOLoadInstructions new.
	self loadOrder do: 
		[ :resolvedDependencyOrCollection | 
		self addLoadGroupFor: resolvedDependencyOrCollection asOrderedCollection ].
	"loadInstructions packageRepositories: #()."
	^ loadInstructions
]

{ #category : #'loading order' }
CGOLoadInstructionsBuilder >> loadOrder [
	| sortedElements |
	
	resolution hasConflicts ifTrue: [ self signalConflicts ].
	
	sortedElements := MalTopologicalSorting new
		privateNodes: self reducedGraph; 
		run.
	^ sortedElements 
		collect: [ :each | each model asOrderedCollection ]
		as: Array
]

{ #category : #'loading order' }
CGOLoadInstructionsBuilder >> reducedGraph [

	^ MalGraphReducer new
		addNodesFrom: resolution
		childrenBlock: [ :resolvedDependency | 
			resolvedDependency resolvedDependencies 
				collect: [ :each | each resolution ]
				thenReject: [ :each | each isInstalledInImage ] ];
		run
]

{ #category : #protocol }
CGOLoadInstructionsBuilder >> resolution: aDependencyResolution [
	resolution := aDependencyResolution
]

{ #category : #errors }
CGOLoadInstructionsBuilder >> signalConflicts [
	
	PBProjectHasConflictsError signalOnResolution: resolution.
	"If the error is resumed, re check the conflicts"
	resolution hasConflicts ifTrue: [ self signalConflicts ].
]
