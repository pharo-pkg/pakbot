"
I represent a Metacello Project and act as a Cargo project.
Dependencies of this project will be loaded by Metacello as a black box for Cargo.
I specify one or many packages / groups to load. Package dependencies are not described and so, a package/group can be seen as a package unit with no dependencies.

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
		'registry'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
PBMetacelloProject class >> fromProjectDependency: aCGOMetacelloProjectDependency [
	^ aCGOMetacelloProjectDependency class projectClass
		repository: aCGOMetacelloProjectDependency repositoryUrl
		name: aCGOMetacelloProjectDependency name
		version: aCGOMetacelloProjectDependency version
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

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> assemblies [
	^ #()
]

{ #category : #loading }
PBMetacelloProject >> basicLoad [
	self subclassResponsibility 
]

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> cargoProjectDependencies [
	^ #()
]

{ #category : #accessing }
PBMetacelloProject >> dependencies [
	^ #()
]

{ #category : #'compatibility - CGOProject' }
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

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> isAssembly [
	" Let's say a CGOMetacelloProject is an assembly so that it will be ignored by PackageGroup mcVersions loading. "
	^ true
]

{ #category : #accessing }
PBMetacelloProject >> isConfiguration [
	self subclassResponsibility
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

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> metacelloProjects [
	^ #()
]

{ #category : #accessing }
PBMetacelloProject >> name [
	^ name
]

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> packageName [
	^ name
]

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> packageUnits [
	^ #()
]

{ #category : #printing }
PBMetacelloProject >> printOn: aStream [
	aStream << self class name << '(' << name << ')'
]

{ #category : #'compatibility - CGOProject' }
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

{ #category : #'compatibility - CGOProject' }
PBMetacelloProject >> virtualPackages [
	^ #()
]
