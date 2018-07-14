"
Cargo Package Manager.
Entry point to deal with dependencies.

packages instance variable holds the list of packages on wich actions will apply.
	NOTE: for now, only one package is allowed / used
"
Class {
	#name : #Cargo,
	#superclass : #Object,
	#instVars : [
		'packages',
		'sourceRepositories',
		'repositories',
		'projectMetadataFromSCM',
		'registry'
	],
	#classVars : [
		'DefaultPackageRepository',
		'PlatformAttributes'
	],
	#category : 'CargoPackageManager-Minimal'
}

{ #category : #accessing }
Cargo class >> defaultPackageRepository [
	^ DefaultPackageRepository ifNil: [ self initialize. DefaultPackageRepository ]
]

{ #category : #accessing }
Cargo class >> defaultPackageRepository: aCGOPackageRepository [
	DefaultPackageRepository := aCGOPackageRepository
]

{ #category : #accessing }
Cargo class >> defaultPackageRepositoryUrl [
	^ 'http://pharo-repo.inria.fr'
]

{ #category : #'class initialization' }
Cargo class >> initialize [
	"initialize default repository if CGORemoteRepositoryProxy is loaded"
	self defaultPackageRepository: 
		(Smalltalk globals 
			at: #CGORemoteRepositoryProxy
			ifPresent: [ :repositoryClass | repositoryClass newWithUrl: self defaultPackageRepositoryUrl ])
]

{ #category : #accessing }
Cargo class >> platformAttributes [
	^ PlatformAttributes ifNil: [ Smalltalk image metacelloPlatformAttributes ]
]

{ #category : #accessing }
Cargo class >> platformAttributes: aListOfPlatformAttributes [
	PlatformAttributes := aListOfPlatformAttributes
]

{ #category : #configuring }
Cargo class >> useLocalRepository: aPathString [
	self defaultPackageRepository: 
		(CGODirectoryPackageRepository newWithUrl: aPathString)
]

{ #category : #configuring }
Cargo >> enablePackageCache [
	sourceRepositories addFirst: MCCacheRepository uniqueInstance
]

{ #category : #initialization }
Cargo >> initialize [
	super initialize.
	projectMetadataFromSCM := CGOScmPackageMetadata new.
	repositories := { projectMetadataFromSCM ". self class defaultPackageRepository" } asOrderedCollection.
	packages := OrderedCollection new.
	registry := CGOPackageRegistry default.
]

{ #category : #actions }
Cargo >> installFrom: aLoadInstructions [
	aLoadInstructions load
]

{ #category : #actions }
Cargo >> installFromFile: aFileReference [
	self installFrom: (STON fromStream: aFileReference readStream)
]

{ #category : #installing }
Cargo >> installProjectFromSourceRepository: aCGOSourceRepository [ 
	| project |

	project := self useSourceRepository: aCGOSourceRepository.
	self package: project packageName version: project version.
	self install
]

{ #category : #private }
Cargo >> installedPackages [
	^ registry installedPackages
		
]

{ #category : #configuring }
Cargo >> package: aPackageName [
	self package: aPackageName version: ''
]

{ #category : #configuring }
Cargo >> package: aPackageName version: aSemanticVersionString [
	packages addIfNotPresent: 
		(CGOPackageVersionReference 
			packageName: aPackageName 
			version: aSemanticVersionString)
]

{ #category : #configuring }
Cargo >> registry: aCGOPackageRegistry [
	"Should only be used to set a registry when performing tests"
	registry := aCGOPackageRegistry
]

{ #category : #private }
Cargo >> rootDependency [
	| pkgVersionRef |
	pkgVersionRef := packages first.
	^ CGOPackageDependency 
		on: pkgVersionRef packageName
		for: nil 
		withConstraints: (pkgVersionRef versionString
			ifEmpty: [ #() ]
			ifNotEmpty: [ {(CGOFixedVersionConstraint with: pkgVersionRef versionString)} ] ) 
]

{ #category : #configuring }
Cargo >> useLocalRepository: aPathString [
	"A local repository takes precedence from the central one but not on package metadata fetch from SCM"
	repositories 
		add: (CGODirectoryPackageRepository newWithUrl: aPathString)
		afterIndex: 1
]

{ #category : #configuring }
Cargo >> useSourceRepository: aCGOSourceRepository [ 
	^ projectMetadataFromSCM registerProjectFromSourceRepository: aCGOSourceRepository
]
