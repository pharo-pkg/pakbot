"
Class used to represent a project whose dependencies have been resolved. It means that we know the specific version of a package to load. To be able to understand the solving afterwards, a link to origin dependencies is kept.
"
Class {
	#name : #PBResolvedProject,
	#superclass : #Object,
	#instVars : [
		'originDependencies',
		'resolvedProjectVersion',
		'resolvedDependencies',
		'isInstalledInImage',
		'packagesToLoad'
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
		and: [ self packagesToLoad = anotherProject packagesToLoad ]
]

{ #category : #adding }
PBResolvedProject >> addAllToLoadList: aListOfPackageName [
	packagesToLoad addAll: aListOfPackageName
]

{ #category : #adding }
PBResolvedProject >> addResolvedDependency: aResolvedDependency [

	resolvedDependencies add: aResolvedDependency 
]

{ #category : #adding }
PBResolvedProject >> addToLoadList: aPackageName [
	packagesToLoad add: aPackageName
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

{ #category : #loading }
PBResolvedProject >> basicLoad [
	packagesToLoad 
		ifEmpty: [ self resolvedProjectVersion basicLoad ]
		ifNotEmpty: [ self resolvedProjectVersion basicLoad: self packagesNotAlreadyInstalledToLoad ] 
]

{ #category : #accessing }
PBResolvedProject >> beInstalledInImage [
	"tells that this project is already installed into the image, no need to load it.
	It is used for Metacello projects not loaded through Cargo but installed and registered in Metacello registry"
	isInstalledInImage := true.
]

{ #category : #icons }
PBResolvedProject >> conflictStatusIconName [
	"We do not display a conflict icon for a resolved project (done on dependencies)"
	^ nil
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
PBResolvedProject >> iconName [

	^ #glamorousBookmark
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
	isInstalledInImage := false.
	packagesToLoad := Set new.
]

{ #category : #comparing }
PBResolvedProject >> isEquivalentTo: aCGOResolvedProject [ 
	
	^ self resolution isEquivalentTo: aCGOResolvedProject resolution
]

{ #category : #testing }
PBResolvedProject >> isInstalled [
	"tells if the project is already installed AND registered in Pakbot registry. A project is already installed if ALL the project packages are installed in the system."
	
	| packagesToCheck |
	packagesToCheck := packagesToLoad ifEmpty: [ resolvedProjectVersion packages collect: #name ].
	
	^ resolvedProjectVersion isRegistered and: [ resolvedProjectVersion hasPackagesLoaded: packagesToCheck ]
]

{ #category : #testing }
PBResolvedProject >> isInstalledInImage [
	"tells if this project is already installed into the image (no need to load it).
	It is used for Metacello projects not loaded through Pakbot but installed and registered in Metacello registry"
	^ isInstalledInImage 
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
	
	^ PBLoadInstructionsBuilder new
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

{ #category : #loading }
PBResolvedProject >> packagesNotAlreadyInstalledToLoad [
	^ packagesToLoad reject: [ :name | (self resolvedProjectVersion packageOrAssemblyNamed: name) isInstalled ]
]

{ #category : #accessing }
PBResolvedProject >> packagesToLoad [
	^ packagesToLoad
]

{ #category : #printing }
PBResolvedProject >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< self resolvedProjectVersion asString
		<< ')'
]

{ #category : #accessing }
PBResolvedProject >> projectVersion [
	^ resolvedProjectVersion version
]

{ #category : #accessing }
PBResolvedProject >> resolution [
	
	^ resolvedProjectVersion
]

{ #category : #solving }
PBResolvedProject >> resolution: aPackageVersionReference [
	| pkgVersion |
	pkgVersion := aPackageVersionReference.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ resolvedProjectVersion := pkgVersion ]
			ifFalse: [ PBDependencyRequirementsUnmet signal ]
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
PBResolvedProject >> resolvedProjectVersion: aPBProject [
	resolvedProjectVersion := aPBProject.
]

{ #category : #solving }
PBResolvedProject >> resolvesDependency: aDependency [
	
	^ false
]

{ #category : #solving }
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

{ #category : #loading }
PBResolvedProject >> versionLoaded [
	"for now, do nothing.
	Maybe we should call versionLoaded on each loaded package?"
]
