"
An InImagePackageProviderStrategyTest is a test class for testing the behavior of InImagePackageProviderStrategy
"
Class {
	#name : #InImagePackageProviderStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'strategy'
	],
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #running }
InImagePackageProviderStrategyTest >> setUp [
	strategy := CGOInImagePackageProviderStrategy new
]

{ #category : #'tests-querying' }
InImagePackageProviderStrategyTest >> testPackageNamed [
	| package |
	package := strategy packageNamed: 'foo'.
	self
		assert: (strategy packageNamed: 'foo') == package
		description: 'Got 2 different object for the same package'
		
]

{ #category : #'tests-querying' }
InImagePackageProviderStrategyTest >> testVirtualPackageNamed [
	| package |
	package := strategy virtualPackageNamed: 'foo'.
	self
		assert: (strategy virtualPackageNamed: 'foo') == package
		description: 'Got 2 different object for the same package'.
	self
		assert: (package isKindOf: CGOVirtualPackage)
		description: 'Not a Virtual package!'
]
