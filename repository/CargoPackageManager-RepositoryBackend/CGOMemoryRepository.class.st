"
In memory PPMRepository using a Voyage backend.
"
Class {
	#name : #CGOMemoryRepository,
	#superclass : #CGOPackageRepository,
	#instVars : [
		'voyageRepository'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #'versions fetching' }
CGOMemoryRepository >> fetch: aPackageName version: aVersion [
	^ (CGOPackageVersion selectOne: 
		[ :each | 
		(each packageName = aPackageName) and: [ each version = aVersion asSemanticVersion ] ])
			ifNil: [ CGOPackageVersionNotFoundError signal ]
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> fetchVirtual: aVirtualPackageName version: aVersion [
	^ (CGOPackageVersion selectOne: 
		[ :each | 
		(each packageName = aVirtualPackageName) and: [ each version = aVersion asSemanticVersion ] ])
			ifNil: [ CGOPackageVersionNotFoundError signal ]
]

{ #category : #initialization }
CGOMemoryRepository >> initialize [
	super initialize.
	voyageRepository := VOMemoryRepository new.
	voyageRepository enableSingleton
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes [
	| candidates |

	candidates := CGOPackageVersion selectMany: 
		[ :each | 
		each packageName = aPackageName
		and: [ self does: each fitPlatformRequirements: platformAttributes ] ].
	^ (candidates detectMax: #version) asPackageVersionReference
]

{ #category : #fetching }
CGOMemoryRepository >> package: aPackageName [
	^ (CGOPackage selectOne: [ :each | each name = aPackageName ])
		ifNil: [ CGOPackageNotFoundError signal: aPackageName ]
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> packageNames [
	^ CGOPackageVersion selectAll
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	| packages |
	
	packages := CGOPackageVersion selectMany: [ :each | 
		each isUnit 
		and: [ (each provides: (CGOPackageVersionReference packageName: aName version: aSemanticVersion))
		and: [ self does: each fitPlatformRequirements: platformAttributes ] ] ].
	^ packages collect: [ :each | each asString ]
]

{ #category : #'versions posting' }
CGOMemoryRepository >> savePackageVersion: aPackageVersion [
	| existingPackageVersion |
	
	existingPackageVersion := self checkPreviousRegistrationOf: aPackageVersion.
	aPackageVersion isDevelopmentVersion
		ifTrue: [ existingPackageVersion 
				ifNil: [ aPackageVersion save ]
				ifNotNil: [ self updatePackageVersion: existingPackageVersion with: aPackageVersion ] ]
		ifFalse: [ aPackageVersion save ]
]

{ #category : #private }
CGOMemoryRepository >> updatePackageVersion: existingPackageVersion with: aPackageVersion [
	(voyageRepository list: CGOPackageVersion)
		remove: existingPackageVersion;
		add: aPackageVersion
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> versionStringsOf: aPackageName [
	"Returns the list of versions available in the repository for the given package name"
	| package |
	
	package := CGOPackageProvider default packageNamed: aPackageName.
	^ CGOPackageVersion selectMany: [ :each | each package = package ]
]

{ #category : #'versions fetching' }
CGOMemoryRepository >> versionStringsOfVirtual: aPackageName [
	| package |
	
	package := CGOPackageProvider default virtualPackageNamed: aPackageName.
	^ CGOPackageVersion selectMany: [ :each | each package = package ]
]
