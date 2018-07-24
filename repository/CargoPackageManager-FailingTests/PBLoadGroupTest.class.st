"
A PackageGroupTest is a test class for testing the behavior of PackageGroup
"
Class {
	#name : #PBLoadGroupTest,
	#superclass : #CGOTest,
	#category : #'CargoPackageManager-FailingTests-Loader'
}

{ #category : #accessing }
PBLoadGroupTest class >> resources [
	^ { GreaseTestResource }
]

{ #category : #'tests-loading' }
PBLoadGroupTest >> testCanGetMCVersionsFromALocalRepositoryWhenRemoteRepositoryNotAvailable [
	| pkgLoadGroup mcVersions |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	mcVersions := pkgLoadGroup mcVersions.
		
	self	
		assert: (mcVersions anySatisfy: [:each | each isKindOf: MCVersion]).
	self	
		assert: mcVersions size
		equals: 1.
	self	
		assert: mcVersions first info name
		equals: 'Grease-Core-JohanBrichau.94'.
]

{ #category : #'tests-loading' }
PBLoadGroupTest >> testCannotGetMCVersionsWhenNoSourceRepositoryAvailable [
	| pkgLoadGroup |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	pkgLoadGroup packageVersions first sourcePackageVersion
		instVarNamed: 'repository' 
		put: nil.

	self 
		should: [ pkgLoadGroup mcVersions ]
		raise: MCRepositoryError

]
