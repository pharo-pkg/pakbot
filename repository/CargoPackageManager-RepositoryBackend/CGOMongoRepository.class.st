"
PPMRepository using Mongo DB and a Voyage backend.
"
Class {
	#name : #CGOMongoRepository,
	#superclass : #CGOPackageRepository,
	#instVars : [
		'voyageRepository'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #'instance creation' }
CGOMongoRepository class >> newWithDbName: aString [
	^ self basicNew
		initializeWithDbName: aString;
		yourself
]

{ #category : #private }
CGOMongoRepository >> beSingleton [
	voyageRepository enableSingleton
]

{ #category : #'versions fetching' }
CGOMongoRepository >> fetch: aPackageName version: aVersion [
	| versionString packageId |
	versionString := aVersion asString.
	packageId := self packageVoyageId: aPackageName.
	^ (CGOPackageVersion selectOne: [ :each | (each at: 'package.__id') = packageId & (each version = versionString) ])
		ifNil: [ CGOPackageVersionNotFoundError signal: 'Cannot find ' , aPackageName , '@' , versionString ]
]

{ #category : #initialization }
CGOMongoRepository >> initializeWithDbName: aString [
	super initialize.
	voyageRepository := VOMongoRepository database: aString.
	voyageRepository enableSingleton
]

{ #category : #'versions fetching' }
CGOMongoRepository >> latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes [
	| candidates packageId |
	
	packageId := self packageVoyageId: aPackageName.
	candidates := CGOPackageVersion selectMany: [ :each | (each at: 'package.__id') = packageId ].
	^ ((candidates 
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ])
			detectMax: #version) asPackageVersionReference
]

{ #category : #fetching }
CGOMongoRepository >> package: aPackageName [
	^ (CGOPackage selectOne: [ :each | each name = aPackageName ])
		ifNil: [ CGOPackageNotFoundError signal: aPackageName ]
]

{ #category : #'versions fetching' }
CGOMongoRepository >> packageNames [
	^ CGOPackageVersion selectAll
]

{ #category : #private }
CGOMongoRepository >> packageVoyageId: aPackageName [
	^ (self package: aPackageName) voyageId
]

{ #category : #'versions fetching' }
CGOMongoRepository >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	| virtualPkgVersionRef packages |
	
	virtualPkgVersionRef := CGOPackageVersionReference 
			packageName: aName 
			version: aSemanticVersion.
	packages := CGOPackageVersion selectMany: 
					[ :each | each provisions includes: virtualPkgVersionRef asString ].
	^ packages 
		select: [ :each | (each platformRequirements difference: platformAttributes) isEmpty ]
		thenCollect: #asString
]

{ #category : #resetting }
CGOMongoRepository >> reset [
	voyageRepository
		removeAll: CGOPackage;
		removeAll: CGOPackageVersion;
		reset
]

{ #category : #'versions posting' }
CGOMongoRepository >> savePackageVersion: aPackageVersion [
	| existingPackageVersion |
	
	existingPackageVersion := self checkPreviousRegistrationOf: aPackageVersion.
	aPackageVersion isDevelopmentVersion
		ifTrue: [ existingPackageVersion 
				ifNil: [ aPackageVersion save ]
				ifNotNil: [ self updatePackageVersion: existingPackageVersion with: aPackageVersion ] ]
		ifFalse: [ aPackageVersion save ]
]

{ #category : #private }
CGOMongoRepository >> updatePackageVersion: existingPackageVersion with: aPackageVersion [
	voyageRepository cache
		at: (voyageRepository idOf: existingPackageVersion)
		put: aPackageVersion.
	aPackageVersion update.
]

{ #category : #'versions fetching' }
CGOMongoRepository >> versionStringsOf: aPackageName [
	"Returns the list of versions available in the repository for the given package name"
	| packageId |
	packageId := self packageVoyageId: aPackageName.
	^ CGOPackageVersion selectMany: [ :each | (each at: 'package.__id') = packageId ]
]
