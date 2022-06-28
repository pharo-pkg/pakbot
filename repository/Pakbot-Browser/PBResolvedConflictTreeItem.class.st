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
	#category : #'Pakbot-Browser-Items'
}

{ #category : #'instance creation' }
PBResolvedConflictTreeItem class >> forOriginal: aPBResolvedProject [ 
	
	^ self new
		beOriginal;
		resolvedDependency: aPBResolvedProject;
		yourself
]

{ #category : #'instance creation' }
PBResolvedConflictTreeItem class >> forResolution: aPBResolvedProject [ 
	
	^ self new
		beResolution;
		resolvedDependency: aPBResolvedProject;
		yourself
]

{ #category : #initialization }
PBResolvedConflictTreeItem >> beOriginal [
	
	isOriginal := true
]

{ #category : #initialization }
PBResolvedConflictTreeItem >> beResolution [
	
	isOriginal := false
]

{ #category : #accessing }
PBResolvedConflictTreeItem >> comment [
	^ isOriginal
		ifTrue: [ 'Calculated Resolution: ' ]
		ifFalse: [ 'Selected Resolution: ' ]
]

{ #category : #icons }
PBResolvedConflictTreeItem >> conflictStatusIconName [

	^ resolvedDependency conflictStatusIconName
]

{ #category : #testing }
PBResolvedConflictTreeItem >> hasToBeExpanded [
	
	isOriginal ifTrue: [ ^ false ].
	^ resolvedDependency hasToBeExpanded
]

{ #category : #icons }
PBResolvedConflictTreeItem >> iconName [

	^ resolvedDependency iconName
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

{ #category : #initialization }
PBResolvedConflictTreeItem >> resolvedDependency: aPBResolvedProject [ 

	resolvedDependency := aPBResolvedProject
]
