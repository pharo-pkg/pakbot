"
I represent a conflict for a project.
It happens when asking to install a project (could be a transitive dependency) but there is: 
- either another dependency on the same project with a different version / url,
- or the project is already installed in the registry (Cargo or Metacello) in a different version / url.

You can see confliciting objects with #dependencies.
The conflict can be solved by using selectedResolution: and provide one of the possible resolutions.
"
Class {
	#name : #PBConflict,
	#superclass : #Object,
	#instVars : [
		'dependencies',
		'selectedResolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance creation' }
PBConflict class >> onConflictingDependencies: aCollection [ 
	
	^ self new
		conflictingDependencies: aCollection;
		yourself
]

{ #category : #accessing }
PBConflict >> conflictingDependencies [
	^ dependencies 
]

{ #category : #accessing }
PBConflict >> conflictingDependencies: aCollection [ 
	dependencies := aCollection
]

{ #category : #accessing }
PBConflict >> dependencies [
	^ dependencies
]

{ #category : #finding }
PBConflict >> findResolution: aSemanticVersion [

	^ self possibleResolutions detect: [ :each | each version = aSemanticVersion ]
]

{ #category : #testing }
PBConflict >> isResolved [
	
	^ selectedResolution isNotNil
]

{ #category : #accessing }
PBConflict >> possibleResolutions [

	^ (dependencies collect: [ :dependency | 
		   dependency originalResolution ]) asOrderedCollection
]

{ #category : #accessing }
PBConflict >> possibleVersions [

	^ self possibleResolutions 
		collect: [ :each | each version ]
]

{ #category : #accessing }
PBConflict >> projectName [
	^ dependencies anyOne projectName
]

{ #category : #testing }
PBConflict >> resolutionFor: aDependency [ 
	
	^ (dependencies detect: [ :each | each dependency = aDependency ]) resolution
]

{ #category : #resolving }
PBConflict >> resolveWithAlreadyInstalled [
	| dependency |
	dependency := dependencies detect: #isInstalledDependency.
	self selectedResolution: dependency resolution.
	self resolveWithSelected

]

{ #category : #resolving }
PBConflict >> resolveWithSelected [
	selectedResolution
		ifNotNil: [ dependencies do: [ :each | each resolveWith: selectedResolution ] ]
]

{ #category : #resolving }
PBConflict >> selectResolution: aResolvedProject [
	aResolvedProject ifNil: [ ^ self ].

	self selectedResolution: aResolvedProject.
	self resolveWithSelected.
]

{ #category : #accessing }
PBConflict >> selectedResolution [

	^ selectedResolution
]

{ #category : #resolving }
PBConflict >> selectedResolution: aPBResolvedProject [ 
	selectedResolution := aPBResolvedProject
]
