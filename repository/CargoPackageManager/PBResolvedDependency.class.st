"
Class used to represent a dependency that has been resolved. It means that we know the specific version of a package to load. 
originalDependency instance variable keeps a reference to the dependency that is now solved.
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

{ #category : #accessing }
PBResolvedDependency class >> conflictIconName [

	^ #error
]

{ #category : #accessing }
PBResolvedDependency class >> noConflictIconName [

	^ #forward 
]

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
PBResolvedDependency >> checkConflictsWithRegistry: aPBPackageRegistry [

	| conflicts |
	conflicts := self conflictingInstalledProjects: aPBPackageRegistry.
	dependencyState := dependencyState withConflicts: conflicts.
]

{ #category : #icons }
PBResolvedDependency >> conflictStatusIconName [

	^ self hasConflicts
		  ifTrue: [ self class conflictIconName ]
		  ifFalse: [ self class noConflictIconName ]
]

{ #category : #conflicts }
PBResolvedDependency >> conflictingDependencies [
	
	^ dependencyState conflictingDependenciesFor: self
]

{ #category : #'conflict testing' }
PBResolvedDependency >> conflictingInstalledProjects: aPBPackageRegistry [
	| conflicts |
	conflicts := (aPBPackageRegistry registeredProjects select: [ :each | each isConflictingWith: self ]), 
						dependency additionalConflictingInstalledProjects.
	^ conflicts collect: [ :each | PBInstalledDependency onResolved: (PBResolvedProject onProject: each)]
]

{ #category : #accessing }
PBResolvedDependency >> dependency [
	^ dependency
]

{ #category : #accessing }
PBResolvedDependency >> dependency: aDependency [ 
	dependency := aDependency
]

{ #category : #accessing }
PBResolvedDependency >> fullVersionString [
	
	^ self originalResolution fullVersionString
]

{ #category : #testing }
PBResolvedDependency >> hasConflicts [
	
	^ dependencyState isConflictingDependency or: [ self resolution hasConflicts ]
]

{ #category : #icons }
PBResolvedDependency >> iconName [

	^ dependency iconName
]

{ #category : #accessing }
PBResolvedDependency >> initialize [

	super initialize.
	dependencyState := PBNonConflictingDependencyState onDependency: self
]

{ #category : #conflicts }
PBResolvedDependency >> isConflictingWith: aPBResolvedDependency [ 
	
	^ (self dependency isSameProjectAs: aPBResolvedDependency dependency)
		and: [ (self resolution isEquivalentTo: aPBResolvedDependency resolution) not ]
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
PBResolvedDependency >> resolveWith: aPBResolvedProject [ 

	dependencyState := dependencyState resolveWith: aPBResolvedProject

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
	| resolvedVersion map |
	self originalResolution hasConflicts 
		ifTrue: [ PBProjectHasConflictsError signalOnResolution: self originalResolution ].
	resolvedVersion := self originalResolution resolvedProjectVersion resolvedVersion.
	map := dependency stonMap 
		at: #version put: resolvedVersion;
		yourself.
	stonWriter writeMap: map.
]

{ #category : #accessing }
PBResolvedDependency >> subresolutions [
	
	^ { self resolution }
]
