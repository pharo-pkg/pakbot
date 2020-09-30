"
I represent a Metacello Project and act as a Cargo project.
Dependencies of this project will be loaded by Metacello as a black box for Cargo.
I can specify one or many packages / groups to load. In this case, I remember the loads instructions in `loadedPackages` i.v.
Package dependencies are not described and so, a package/group can be seen as a package unit with no dependencies.

	See my subclasses for examples
"
Class {
	#name : #PBMetacelloProject,
	#superclass : #Object,
	#instVars : [
		'repository',
		'name',
		'version',
		'packageNames',
		'registry',
		'loadedPackages'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
PBMetacelloProject class >> fromProjectDependency: aPBMetacelloProjectDependency [
	^ aPBMetacelloProjectDependency class projectClass
		repository: aPBMetacelloProjectDependency repositoryUrl
		name: aPBMetacelloProjectDependency name
		version: aPBMetacelloProjectDependency version
]

{ #category : #'instance creation' }
PBMetacelloProject class >> repository: repositoryString name: projectName version: versionString [ 
	^ self new 
		initializeWithRepository: repositoryString name: projectName version: versionString 

		
	
]

{ #category : #comparing }
PBMetacelloProject >> = anotherProject [

	self species = anotherProject	species
		ifFalse: [ ^ false ].
		
	self name = anotherProject name
		ifFalse: [ ^ false ].

	self version = anotherProject version
		ifFalse: [ ^ false ].
		
	self repository = anotherProject repository
		ifFalse: [ ^ false ].
		
	^ true
]

{ #category : #converting }
PBMetacelloProject >> asPackageVersionReference [

	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: (SemanticVersion fromString: version)
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> assemblies [
	^ #()
]

{ #category : #loading }
PBMetacelloProject >> basicLoad [
	self subclassResponsibility 
]

{ #category : #accessing }
PBMetacelloProject >> dependencies [
	^ #()
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> fitsPlatformRequirements [
	^ true "it should be managed by Metecello"
]

{ #category : #accessing }
PBMetacelloProject >> fullyQualifiedName [
	^ self name
]

{ #category : #testing }
PBMetacelloProject >> hasPackage: aPackageName [
	packageNames add: aPackageName.
	"No way to check that the package exist in the current Metacello project without actually loading the code.
	We just remember the package name and assume it is valid."
	^ true
]

{ #category : #testing }
PBMetacelloProject >> hasProblems [
	^ false
]

{ #category : #comparing }
PBMetacelloProject >> hash [

	^ self name hash bitXor: self version hash
]

{ #category : #initialization }
PBMetacelloProject >> initializeWithRepository: repositoryString name: projectName version: versionString [ 
	repository := repositoryString.
	name := projectName.
	version := versionString.
	packageNames := OrderedCollection new.
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> isAssembly [
	" Let's say a CGOMetacelloProject is an assembly so that it will be ignored by PackageGroup mcVersions loading. "
	^ true
]

{ #category : #accessing }
PBMetacelloProject >> isConfiguration [
	self subclassResponsibility
]

{ #category : #conflicts }
PBMetacelloProject >> isConflictingWith: aPBResolvedDependency [ 
	
	^ (self name = aPBResolvedDependency name)
		and: [ self ~= aPBResolvedDependency resolution resolvedProjectVersion ]
]

{ #category : #comparing }
PBMetacelloProject >> isEquivalentTo: anotherProject [
	"In this comparison the project is compared against the resolved version. 
	To solve the problem when it uses non fixed versions."
	
	self species = anotherProject	species
		ifFalse: [ ^ false ].
		
	self name = anotherProject name
		ifFalse: [ ^ false ].

	self resolvedVersion = anotherProject resolvedVersion
		ifFalse: [ ^ false ].
		
	self repository = anotherProject repository
		ifFalse: [ ^ false ].
		
	^ true
]

{ #category : #testing }
PBMetacelloProject >> isInstalled [
	
	^ registry isInstalled: self
]

{ #category : #testing }
PBMetacelloProject >> isMetacelloProject [
	^ true
]

{ #category : #'compatibility - package repository' }
PBMetacelloProject >> isVirtual [
	^ false
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> metacelloProjects [
	^ #()
]

{ #category : #accessing }
PBMetacelloProject >> name [
	^ name
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> packageName [
	^ name
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> packageUnits [
	^ #()
]

{ #category : #accessing }
PBMetacelloProject >> packages [
	^ #()
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> pakbotProjectDependencies [
	^ #()
]

{ #category : #printing }
PBMetacelloProject >> printOn: aStream [
	aStream << self class name << '(' << name << ')'
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> project [
	^ self
]

{ #category : #accessing }
PBMetacelloProject >> registry: aCGOPackageRegistry [ 
	registry := aCGOPackageRegistry.
	^ self
]

{ #category : #accessing }
PBMetacelloProject >> repository [
	^ repository
]

{ #category : #accessing }
PBMetacelloProject >> version [
	^ version
]

{ #category : #loading }
PBMetacelloProject >> versionLoaded [
	"Nothing to do"
]

{ #category : #'compatibility - PBProjectVersion' }
PBMetacelloProject >> virtualPackages [
	^ #()
]
