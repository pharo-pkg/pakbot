"
Sort dependencies from leafs to the root.
"
Class {
	#name : #PBLoadInstructionsBuilder,
	#superclass : #Object,
	#instVars : [
		'graph',
		'resolution',
		'loadInstructions'
	],
	#category : #'CargoPackageManager-Loading'
}

{ #category : #'loading order' }
PBLoadInstructionsBuilder >> addLoadGroupFor: resolvedDependencies [
	| resolvedProjects |

	resolvedProjects := (resolvedDependencies reject: #isInstalled) asArray.
	resolvedProjects 
		ifNotEmpty: [ loadInstructions addGroup: (PBLoadGroup newWithAll: resolvedProjects) ]
]

{ #category : #'loading order' }
PBLoadInstructionsBuilder >> loadInstructions [
	loadInstructions := PBLoadInstructions new.
	self loadOrder do: 
		[ :resolvedDependencyOrCollection | 
		self addLoadGroupFor: resolvedDependencyOrCollection asOrderedCollection ].
	"loadInstructions packageRepositories: #()."
	^ loadInstructions
]

{ #category : #'loading order' }
PBLoadInstructionsBuilder >> loadOrder [
	| sortedElements |
	
	resolution hasConflicts ifTrue: [ self signalConflicts ].
	
	sortedElements := AITopologicalSorting new
		addNodesFromDifferentGraph: self reducedGraph; 
		run.
	^ sortedElements 
		collect: [ :each | OrderedCollection with: each ]
		as: Array
]

{ #category : #'loading order' }
PBLoadInstructionsBuilder >> reducedGraph [

	^ AIGraphReducer new
		addNodesFrom: resolution
		childrenBlock: [ :resolvedDependency | 
			(resolvedDependency resolvedDependencies sorted: [ :a :b | a name < b name ])
				collect: [ :each | each resolution ]
				thenReject: [ :each | each isInstalledInImage ] ];
		run
]

{ #category : #protocol }
PBLoadInstructionsBuilder >> resolution: aDependencyResolution [
	resolution := aDependencyResolution
]

{ #category : #errors }
PBLoadInstructionsBuilder >> signalConflicts [
	
	PBProjectHasConflictsError signalOnResolution: resolution.
	"If the error is resumed, re check the conflicts"
	resolution hasConflicts ifTrue: [ self signalConflicts ].
]
