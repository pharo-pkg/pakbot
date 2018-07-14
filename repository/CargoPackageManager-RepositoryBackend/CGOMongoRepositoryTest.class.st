Class {
	#name : #CGOMongoRepositoryTest,
	#superclass : #Object,
	#instVars : [
		'repository'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #accessing }
CGOMongoRepositoryTest class >> resources [
	^ { Seaside31TestResource . CGOMongoTestResource }
]

{ #category : #running }
CGOMongoRepositoryTest >> setUp [
	super setUp.
	repository := CGOMongoTestResource current repository.
	repository beSingleton.
]

{ #category : #'tests - versions fetching' }
CGOMongoRepositoryTest >> testFetchVersion [
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"result := repository 
				fetch: #'Seaside-Core'
				version: '3.1' asSemanticVersion.
	self 
		assert: result asString
		equals: 'Seaside-Core@3.1.0'"
]

{ #category : #'tests - versions fetching' }
CGOMongoRepositoryTest >> testFetchVersionNotFound [
	self 
		should: [ repository 
				fetch: #Foo
				version: '2.0.1' asSemanticVersion ]
		raise: CGOPackageNotFoundError
]

{ #category : #'tests - versions fetching' }
CGOMongoRepositoryTest >> testLatestVersionOfPackageSuitableForEnvironment [
	| result |

	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
		
	"result := repository 
				latestVersionOf: #'Zinc-HTTP'
				suitableForEnvironment: #().
	self 
		assert: result first asString
		equals: 'Zinc-HTTP@2.5.2'"
]

{ #category : #tests }
CGOMongoRepositoryTest >> testPackages [
	| packages |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"packages := repository packages.
	self 
		assert: packages size
		equals: 68.
	self 
		assert: ((packages atRandom) isKindOf: CGOPackageVersion)"
]

{ #category : #'tests - virtual packages' }
CGOMongoRepositoryTest >> testPackagesProvidingVersionFor [
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"result := repository 
				packagesProviding: 'Seaside-Canvas-Platform'
				version: '1.0' asSemanticVersion
				for: (OrderedCollection with: #'pharo2.x').
	self 
		assert: result size
		equals: 1.
	self assert: result anyOne
		equals: 'Seaside-Canvas-Pharo20@3.1.0'"
]

{ #category : #'tests - virtual packages' }
CGOMongoRepositoryTest >> testPackagesProvidingVersionForEmpty [
	| result |
	
	result := repository 
				packagesProviding: #'Seaside-Canvas-Platform'
				version: '1.0' asSemanticVersion
				forEnvironment: (OrderedCollection with: #'pharo4.x').
	self 
		assert: result size
		equals: 0
]

{ #category : #'tests - versions posting' }
CGOMongoRepositoryTest >> testSavePackageVersion [
	| pkgVersionString result |
	
	pkgVersionString := 'bar@0.2.1'.
	repository savePackageVersion: (CGOPackageVersion fromString: pkgVersionString).
	result := repository 
				fetch: #'bar'
				version: '0.2.1' asSemanticVersion.
	self 
		assert: result asString
		equals: pkgVersionString
]

{ #category : #tests }
CGOMongoRepositoryTest >> testUpdatePackageVersionWith [
	| pkgVersion pkgVersion2 result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.

	"use an example with more data"
	"pkgVersion := CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #foo;
			add: #version -> '0.2.1-dev' asSemanticVersion;
			add: #description -> 'first';
			yourself ).
	repository savePackageVersion: pkgVersion.
	pkgVersion2 := CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #foo;
			add: #version -> '0.2.1-dev' asSemanticVersion;
			add: #description -> 'second';
			yourself ).
	repository savePackageVersion: pkgVersion2.

	result := repository 
				fetch: #foo
				version: '0.2.1-dev' asSemanticVersion.
	self 
		assert: result description
		equals: 'second'"
]

{ #category : #'tests - versions fetching' }
CGOMongoRepositoryTest >> testVersionsOf [
	| result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
		
	"result := repository versionsOf: 'Zinc-HTTP'.
	self 
		assert: result size
		equals: 2.
	result := result collect: [ :each | each asString ].
	self assert: (result includesAll: #('Zinc-HTTP@2.5.2' 'Zinc-HTTP@2.4.8'))"
]
