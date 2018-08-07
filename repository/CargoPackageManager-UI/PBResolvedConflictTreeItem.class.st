"
I represent the item when there is a resolved dependency.
It shows the original resolved dependency and the manually selected.
"
Class {
	#name : #PBResolvedConflictTreeItem,
	#superclass : #Object,
	#instVars : [
		'resolvedDependency',
		'isOriginal'
	],
	#category : #'CargoPackageManager-UI-Resolution'
}

{ #category : #'instance-creation' }
PBResolvedConflictTreeItem class >> forOriginal: aCGOResolvedProject [ 
	
	^ self new
		beOriginal;
		resolvedDependency: aCGOResolvedProject;
		yourself
]

{ #category : #'instance creation' }
PBResolvedConflictTreeItem class >> forResolution: aCGOResolvedProject [ 
	
	^ self new
		beResolution;
		resolvedDependency: aCGOResolvedProject;
		yourself
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> beOriginal [
	
	isOriginal := true
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> beResolution [
	
	isOriginal := false
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> comment [
	^ isOriginal
		ifTrue: [ 'Calculated Resolution: ' ]
		ifFalse: [ 'Selected Resolution: ' ]
]

{ #category : #testing }
PBResolvedConflictTreeItem >> hasToBeExpanded [
	
	isOriginal ifTrue: [ ^ false ].
	^ resolvedDependency hasToBeExpanded
]

{ #category : #icons }
PBResolvedConflictTreeItem >> icons [
	^ resolvedDependency icons
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> name [
	^ self comment , resolvedDependency name
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> nameWithVersion [
	
	^ self comment , resolvedDependency nameWithVersion 
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> nodesInResolutionTree [
	
	^ resolvedDependency nodesInResolutionTree
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> resolvedDependency: aCGOResolvedProject [ 
	resolvedDependency := aCGOResolvedProject
]
