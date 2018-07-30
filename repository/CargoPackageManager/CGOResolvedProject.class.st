"
Class used to represent a dependency that has been resolved. It means that we know the specific version of a package to load. To be able to understand the solving afterwards, a link to origin dependencies is kept.
"
Class {
	#name : #CGOResolvedProject,
	#superclass : #Object,
	#instVars : [
		'originDependencies',
		'resolvedProjectVersion',
		'resolvedDependencies'
	],
	#category : 'CargoPackageManager-Solver'
}

{ #category : #'instance-creation' }
CGOResolvedProject class >> onProject: aProject [
	
	^ self new
		resolvedProjectVersion: aProject;
		yourself
]

{ #category : #comparing }
CGOResolvedProject >> = anotherProject [

	self species = anotherProject species
		ifFalse: [ ^ false ].
		
	^ self resolution = anotherProject resolution
]

{ #category : #adding }
CGOResolvedProject >> addResolvedDependency: aResolvedDependency [

	resolvedDependencies add: aResolvedDependency 
]

{ #category : #accessing }
CGOResolvedProject >> allResolvedDependencies [
	
	| indirectDependencies |
	indirectDependencies := self resolvedDependencies
		flatCollect: [ :each | each resolution allResolvedDependencies ].
	^ self resolvedDependencies, indirectDependencies
]

{ #category : #accessing }
CGOResolvedProject >> allSubResolutions [
	
	^ self subresolutions asArray , (self subresolutions asArray flatCollect: [ :each | each allSubResolutions asArray ])
]

{ #category : #conflicts }
CGOResolvedProject >> conflictingDependencies [
	
	^ self resolvedDependencies select: [ :e | e hasConflicts ]
]

{ #category : #conflicts }
CGOResolvedProject >> conflicts [

	| allConflicting |
	
	allConflicting := self conflictingDependencies flatCollect: [ :each | each conflictingDependencies ].

	^ (allConflicting groupedBy: [ :aConflictingDependency | aConflictingDependency projectName ]) 
		associations collect: [ :assoc | PBConflict onConflictingDependencies: assoc value ]
]

{ #category : #accessing }
CGOResolvedProject >> dependencyTargetedPackages [

	^ resolvedProjectVersion dependencies collect: [ :each | each name ]
]

{ #category : #testing }
CGOResolvedProject >> fitsPlatformRequirements [
	^ resolvedProjectVersion fitsPlatformRequirements
]

{ #category : #testing }
CGOResolvedProject >> hasConflicts [
	
	^ self resolvedDependencies anySatisfy: [ :any | any hasConflicts ]
]

{ #category : #comparing }
CGOResolvedProject >> hash [

	^ self resolution hash
]

{ #category : #accessing }
CGOResolvedProject >> icons [
	^ { self iconNamed: #glamorousBookmark }
]

{ #category : #lookup }
CGOResolvedProject >> includesResolvedTarget: aResolutionTarget [

	(self resolvesTarget: aResolutionTarget)
		ifTrue: [ ^ true ].

	^ self allSubResolutions anySatisfy: [ :any | 
		any resolvesTarget: aResolutionTarget ]
]

{ #category : #initialization }
CGOResolvedProject >> initialize [
	super initialize.
	originDependencies := Set new.
	resolvedDependencies := Set new.
]

{ #category : #testing }
CGOResolvedProject >> isInstalled [
	
	^ resolvedProjectVersion isInstalled
]

{ #category : #testing }
CGOResolvedProject >> isSolved [
	^ resolvedProjectVersion isNotNil
]

{ #category : #loading }
CGOResolvedProject >> load [
	
	self loadInstructions load
]

{ #category : #loading }
CGOResolvedProject >> loadInstructions [
	
	^ CGOLoadInstructionsBuilder new
		resolution: self;
		loadInstructions
]

{ #category : #accessing }
CGOResolvedProject >> name [
	^ resolvedProjectVersion name
]

{ #category : #accessing }
CGOResolvedProject >> nameWithVersion [
	^ self name , ' ', self projectVersion asString
]

{ #category : #accessing }
CGOResolvedProject >> originDependencies [
	^ originDependencies
]

{ #category : #printing }
CGOResolvedProject >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< self resolvedProjectVersion asString
		<< ')'
]

{ #category : #accessing }
CGOResolvedProject >> resolution [
	
	^ resolvedProjectVersion
]

{ #category : #resolution }
CGOResolvedProject >> resolution: aPackageVersionReference [
	| pkgVersion |
	pkgVersion := aPackageVersionReference.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ resolvedProjectVersion := pkgVersion ]
			ifFalse: [ CGODependencyRequirementsUnmet signal ]
]

{ #category : #lookup }
CGOResolvedProject >> resolutionFor: aResolutionTarget [
	
	(aResolutionTarget isResolvedBy: self)
		ifTrue: [ ^ self ].
	
	^ self allSubResolutions detect: [ :any | aResolutionTarget isResolvedBy: any ]
]

{ #category : #accessing }
CGOResolvedProject >> resolvedDependencies [
	
	^ resolvedDependencies
]

{ #category : #accessing }
CGOResolvedProject >> resolvedProjectVersion [
	^ resolvedProjectVersion
]

{ #category : #accessing }
CGOResolvedProject >> resolvedProjectVersion: anObject [
	resolvedProjectVersion := anObject
]

{ #category : #resolving }
CGOResolvedProject >> resolvesDependency: aDependency [
	
	^ false
]

{ #category : #resolution }
CGOResolvedProject >> resolvesProject: aProject [ 
	
	^ resolvedProjectVersion = aProject
]

{ #category : #solving }
CGOResolvedProject >> resolvesTarget: aResolutionTarget [ 
	
	^ resolvedProjectVersion = aResolutionTarget
]

{ #category : #adding }
CGOResolvedProject >> rootProject: aDependency [
	originDependencies add: aDependency
]

{ #category : #accessing }
CGOResolvedProject >> subresolutions [
	
	^ self resolvedDependencies
]

{ #category : #accessing }
CGOResolvedProject >> version [
	
	^ resolvedProjectVersion version
]
