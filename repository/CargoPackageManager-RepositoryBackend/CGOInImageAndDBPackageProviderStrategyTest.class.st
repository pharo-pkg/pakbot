Class {
	#name : #CGOInImageAndDBPackageProviderStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'strategy'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #running }
CGOInImageAndDBPackageProviderStrategyTest >> setUp [
	strategy := CGOInImageAndDBPackageProviderStrategy new
]

{ #category : #'tests-querying' }
CGOInImageAndDBPackageProviderStrategyTest >> testPackageNamed [
	| package |
	package := strategy packageNamed: #foo.
	
	self
		assert: (strategy packageNamed: #foo) == package
		description: 'Got 2 different object for the same package'
		
]

{ #category : #'tests-querying' }
CGOInImageAndDBPackageProviderStrategyTest >> testVirtualPackageNamed [
	| package |
	package := strategy virtualPackageNamed: #foo.
	self
		assert: (strategy virtualPackageNamed: #foo) == package
		description: 'Got 2 different object for the same package'.
	self
		assert: (package isKindOf: CGOVirtualPackage)
		description: 'Not a Virtual package!'
]
