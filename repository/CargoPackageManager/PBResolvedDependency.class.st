"
Class used to represent a dependency that has been resolved. It means that we know the specific version of a package to load. 
"
Class {
	#name : #PBResolvedDependency,
	#superclass : #Object,
	#instVars : [
		'dependency',
		'dependencyState',
		'originalResolution'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance-creation' }
PBResolvedDependency class >> onDependency: aDependency resolution: aResolution [
	
	^ self new
		dependency: aDependency;
		originalResolution: aResolution;
		yourself
]

{ #category : #accessing }
PBResolvedDependency >> allSubResolutions [
	
	^ { self resolution }, self resolution allSubResolutions asArray
]

{ #category : #conflicts }
PBResolvedDependency >> checkConflictsWithDependencies: aDependencyCollection [
	
	| conflicts |
	conflicts := aDependencyCollection select: [ :each | each isConflictingWith: self ].
	dependencyState := dependencyState withConflicts: conflicts.
]

{ #category : #conflicts }
PBResolvedDependency >> checkConflictsWithRegistry: aCGOPackageRegistry [

	| conflicts |
	conflicts := self conflictingInstalledProjects: aCGOPackageRegistry.
	dependencyState := dependencyState withConflicts: conflicts.
]

{ #category : #conflicts }
PBResolvedDependency >> conflictingDependencies [
	
	^ dependencyState conflictingDependenciesFor: self
]

{ #category : #'conflict testing' }
PBResolvedDependency >> conflictingInstalledProjects: aCGOPackageRegistry [

	^ ((aCGOPackageRegistry registeredProjects select: [ :each | each isConflictingWith: self ]), dependency additionalConflictingInstalledProjects) collect: [ :each | CGOInstalledDependency onResolved: (PBResolvedProject onProject: each)]
]

{ #category : #accessing }
PBResolvedDependency >> dependency [
	^ dependency
]

{ #category : #accessing }
PBResolvedDependency >> dependency: aDependency [ 
	dependency := aDependency
]

{ #category : #testing }
PBResolvedDependency >> hasConflicts [
	
	^ dependencyState isConflictingDependency or: [ self resolution hasConflicts ]
]

{ #category : #accessing }
PBResolvedDependency >> icons [
	^ {
		self iconNamed: (self hasConflicts ifTrue: [ #error ] ifFalse: [ #forward ]).
		self iconNamed: dependency iconName }
]

{ #category : #accessing }
PBResolvedDependency >> initialize [

	super initialize.
	dependencyState := PBNonConflictingDependencyState onDependency: self
]

{ #category : #conflicts }
PBResolvedDependency >> isConflictingWith: aCGOResolvedDependency [ 
	
	^ (self dependency isSameProjectAs: aCGOResolvedDependency dependency)
		and: [ (self resolution isEquivalentTo: aCGOResolvedDependency resolution) not ]
]

{ #category : #testing }
PBResolvedDependency >> isInstalledDependency [
	
	^ false
]

{ #category : #accessing }
PBResolvedDependency >> name [
	
	^ dependency name
]

{ #category : #accessing }
PBResolvedDependency >> nameWithVersion [
	
	^ dependency name , ' ', dependency version
]

{ #category : #'*CargoPackageManager' }
PBResolvedDependency >> nodesInResolutionTree [
	
	^ dependencyState nodesInResolutionTree
]

{ #category : #accessing }
PBResolvedDependency >> originalResolution [
	^ originalResolution
]

{ #category : #accessing }
PBResolvedDependency >> originalResolution: aProject [
	
	originalResolution := aProject
]

{ #category : #printing }
PBResolvedDependency >> printOn: aStream [

	aStream
		<< self class name
		<< '('
		<< dependency asString
		<< ' => '
		<< self resolution asString
		<< ')'
]

{ #category : #accessing }
PBResolvedDependency >> projectName [
	^ self resolution name
]

{ #category : #accessing }
PBResolvedDependency >> resolution [
	
	^ dependencyState resolutionFor: self
]

{ #category : #resolving }
PBResolvedDependency >> resolveWith: aCGOResolvedProject [ 

	dependencyState := dependencyState resolveWith: aCGOResolvedProject

]

{ #category : #resolving }
PBResolvedDependency >> resolvesDependency: aDependency [ 
	
	^ dependency = aDependency
]

{ #category : #resolution }
PBResolvedDependency >> resolvesProject: aProject [
	
	^ false
]

{ #category : #solving }
PBResolvedDependency >> resolvesTarget: aResolutionTarget [ 
	
	^ self resolution resolvedProjectVersion = aResolutionTarget
]

{ #category : #ston }
PBResolvedDependency >> stonOn: stonWriter [
	| resolvedVersion |
	self originalResolution hasConflicts 
		ifTrue: [ PBProjectHasConflictsError signalOnResolution: self originalResolution ].
	resolvedVersion := self originalResolution resolvedProjectVersion resolvedVersion.
	stonWriter writeMap: (OrderedDictionary 
		with: 	#configuration -> dependency name
		with:	#url -> dependency repositoryUrl asString
		with: 	#version -> resolvedVersion)
]

{ #category : #accessing }
PBResolvedDependency >> subresolutions [
	
	^ { self resolution }
]
