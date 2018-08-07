"
Class used to represent a dependency that has been resolved. It means that we know the specific version of a package to load. To be able to understand the solving afterwards, a link to origin dependencies is kept.
"
Class {
	#name : #PBResolvedProject,
	#superclass : #Object,
	#instVars : [
		'originDependencies',
		'resolvedProjectVersion',
		'resolvedDependencies'
	],
	#category : #'CargoPackageManager-Solver'
}

{ #category : #'instance-creation' }
PBResolvedProject class >> onProject: aProject [
	
	^ self new
		resolvedProjectVersion: aProject;
		yourself
]

{ #category : #comparing }
PBResolvedProject >> = anotherProject [

	self species = anotherProject species
		ifFalse: [ ^ false ].
		
	^ self resolution = anotherProject resolution
]

{ #category : #adding }
PBResolvedProject >> addResolvedDependency: aResolvedDependency [

	resolvedDependencies add: aResolvedDependency 
]

{ #category : #accessing }
PBResolvedProject >> allResolvedDependencies [
	
	| indirectDependencies |
	indirectDependencies := self resolvedDependencies
		flatCollect: [ :each | each resolution allResolvedDependencies ].
	^ self resolvedDependencies, indirectDependencies
]

{ #category : #accessing }
PBResolvedProject >> allSubResolutions [
	
	^ self subresolutions asArray , (self subresolutions asArray flatCollect: [ :each | each allSubResolutions asArray ])
]

{ #category : #conflicts }
PBResolvedProject >> conflictingDependencies [
	
	^ self resolvedDependencies select: [ :e | e hasConflicts ]
]

{ #category : #conflicts }
PBResolvedProject >> conflicts [

	| allConflicting |
	
	allConflicting := self conflictingDependencies flatCollect: [ :each | each conflictingDependencies ].

	^ (allConflicting groupedBy: [ :aConflictingDependency | aConflictingDependency projectName ]) 
		associations collect: [ :assoc | PBConflict onConflictingDependencies: assoc value ]
]

{ #category : #accessing }
PBResolvedProject >> dependencyTargetedPackages [

	^ resolvedProjectVersion dependencies collect: [ :each | each name ]
]

{ #category : #testing }
PBResolvedProject >> fitsPlatformRequirements [
	^ resolvedProjectVersion fitsPlatformRequirements
]

{ #category : #testing }
PBResolvedProject >> hasConflicts [
	
	^ self resolvedDependencies anySatisfy: [ :any | any hasConflicts ]
]

{ #category : #comparing }
PBResolvedProject >> hash [

	^ self resolution hash
]

{ #category : #accessing }
PBResolvedProject >> icons [
	^ { self iconNamed: #glamorousBookmark }
]

{ #category : #lookup }
PBResolvedProject >> includesResolvedTarget: aResolutionTarget [

	(self resolvesTarget: aResolutionTarget)
		ifTrue: [ ^ true ].

	^ self allSubResolutions anySatisfy: [ :any | 
		any resolvesTarget: aResolutionTarget ]
]

{ #category : #initialization }
PBResolvedProject >> initialize [
	super initialize.
	originDependencies := Set new.
	resolvedDependencies := Set new.
]

{ #category : #comparison }
PBResolvedProject >> isEquivalentTo: aCGOResolvedProject [ 
	
	^ self resolution isEquivalentTo: aCGOResolvedProject resolution
]

{ #category : #testing }
PBResolvedProject >> isInstalled [
	
	^ resolvedProjectVersion isInstalled
]

{ #category : #testing }
PBResolvedProject >> isSolved [
	^ resolvedProjectVersion isNotNil
]

{ #category : #loading }
PBResolvedProject >> load [
	
	self loadInstructions load
]

{ #category : #loading }
PBResolvedProject >> loadInstructions [
	
	^ CGOLoadInstructionsBuilder new
		resolution: self;
		loadInstructions
]

{ #category : #accessing }
PBResolvedProject >> name [
	^ resolvedProjectVersion name
]

{ #category : #accessing }
PBResolvedProject >> nameWithVersion [
	^ self name , ' ', self projectVersion asString
]

{ #category : #accessing }
PBResolvedProject >> originDependencies [
	^ originDependencies
]

{ #category : #printing }
PBResolvedProject >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< self resolvedProjectVersion asString
		<< ')'
]

{ #category : #accesskng }
PBResolvedProject >> projectVersion [
	^ resolvedProjectVersion version
]

{ #category : #accessing }
PBResolvedProject >> resolution [
	
	^ resolvedProjectVersion
]

{ #category : #resolution }
PBResolvedProject >> resolution: aPackageVersionReference [
	| pkgVersion |
	pkgVersion := aPackageVersionReference.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ resolvedProjectVersion := pkgVersion ]
			ifFalse: [ CGODependencyRequirementsUnmet signal ]
]

{ #category : #lookup }
PBResolvedProject >> resolutionFor: aResolutionTarget [
	
	(aResolutionTarget isResolvedBy: self)
		ifTrue: [ ^ self ].
	
	^ self allSubResolutions detect: [ :any | aResolutionTarget isResolvedBy: any ]
]

{ #category : #accessing }
PBResolvedProject >> resolvedDependencies [
	
	^ resolvedDependencies
]

{ #category : #accessing }
PBResolvedProject >> resolvedProjectVersion [
	^ resolvedProjectVersion
]

{ #category : #accessing }
PBResolvedProject >> resolvedProjectVersion: anObject [
	resolvedProjectVersion := anObject
]

{ #category : #resolving }
PBResolvedProject >> resolvesDependency: aDependency [
	
	^ false
]

{ #category : #resolution }
PBResolvedProject >> resolvesProject: aProject [ 
	
	^ resolvedProjectVersion = aProject
]

{ #category : #solving }
PBResolvedProject >> resolvesTarget: aResolutionTarget [ 
	
	^ resolvedProjectVersion = aResolutionTarget
]

{ #category : #adding }
PBResolvedProject >> rootProject: aDependency [
	originDependencies add: aDependency
]

{ #category : #accessing }
PBResolvedProject >> subresolutions [
	
	^ self resolvedDependencies
]

{ #category : #accessing }
PBResolvedProject >> version [
	
	^ resolvedProjectVersion version
]
