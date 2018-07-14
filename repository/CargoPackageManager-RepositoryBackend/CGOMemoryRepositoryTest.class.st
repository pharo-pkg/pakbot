Class {
	#name : #CGOMemoryRepositoryTest,
	#superclass : #CGOTest,
	#instVars : [
		'repository'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #running }
CGOMemoryRepositoryTest >> setUp [
	super setUp.
	repository := CGOMemoryRepository new.
	self packageVersions do: #save.
	self packages do: #save "workaround for the voyage bug: https://github.com/estebanlm/voyage/issues/2"
]

{ #category : #'tests - versions fetching' }
CGOMemoryRepositoryTest >> testFetchVersion [
	| result |
	
	result := repository 
				fetch: #'Seaside-Core'
				version: '3.1' asSemanticVersion.
	self 
		assert: result asString
		equals: 'Seaside-Core@3.1.0'
]

{ #category : #'tests - versions fetching' }
CGOMemoryRepositoryTest >> testFetchVersionNotFound [
	self 
		should: [ repository 
				fetch: #Foo
				version: '2.0.1' asSemanticVersion ]
		raise: CGOPackageVersionNotFoundError
]

{ #category : #'tests - versions fetching' }
CGOMemoryRepositoryTest >> testLatestVersionOfPackageSuitableForEnvironment [
	| result |
	
	result := repository 
				latestVersionOfPackage: #'Zinc-HTTP'
				suitableForEnvironment: #().
	self 
		assert: result asString
		equals: 'Zinc-HTTP@2.5.2'
]

{ #category : #tests }
CGOMemoryRepositoryTest >> testPackages [
	| packages |
	
	packages := repository packageNames.
	self 
		assert: packages size
		equals: 67.
	self 
		assert: ((packages atRandom) isKindOf: CGOPackageVersion)
]

{ #category : #'tests - virtual packages' }
CGOMemoryRepositoryTest >> testPackagesProvidingVersionFor [
	| result |
	
	result := repository 
				packagesProviding: 'Seaside-Canvas-Platform'
				version: '1.0' asSemanticVersion
				forEnvironment: (OrderedCollection with: #'pharo2.x').
	self 
		assert: result size
		equals: 1.
	self assert: result anyOne
		equals: 'Seaside-Canvas-Pharo20@3.1.0'
]

{ #category : #'tests - virtual packages' }
CGOMemoryRepositoryTest >> testPackagesProvidingVersionForEmpty [
	| result |
	
	result := repository 
				packagesProviding: 'Seaside-Canvas-Platform'
				version: '1.0' asSemanticVersion
				forEnvironment: (OrderedCollection with: #'pharo4.x').
	self 
		assert: result size
		equals: 0
]

{ #category : #'tests - versions posting' }
CGOMemoryRepositoryTest >> testSavePackageVersion [
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
CGOMemoryRepositoryTest >> testUpdatePackageVersionWith [
	| pkgVersion pkgVersion2 result |
	
	"use an example with more data"
	pkgVersion := CGOPackageVersion newFrom: 
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
		equals: 'second'
]

{ #category : #'tests - versions fetching' }
CGOMemoryRepositoryTest >> testVersionsOf [
	| result |
	
	result := repository versionStringsOf: 'Zinc-HTTP'.
	self 
		assert: result size
		equals: 2.
	result := result collect: [ :each | each asString ].
	self 
		assert: result asArray
		equals: #('Zinc-HTTP@2.4.8' 'Zinc-HTTP@2.5.2')
]
