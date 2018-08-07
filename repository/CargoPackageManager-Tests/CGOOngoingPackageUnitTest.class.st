Class {
	#name : #CGOOngoingPackageUnitTest,
	#superclass : #CGOModelTest,
	#instVars : [
		'oldPackageRegistry'
	],
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
CGOOngoingPackageUnitTest >> testCanCreateMinimalOngoingPackageUnit [
	| unit |
	unit := PBPackage named: #Test.
	self assert: unit class equals: PBPackage
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testCanGetProjectFromOngoingPackageUnit [
	self
		assert: self unitTestV1 project 
		equals: ongoingProject
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testCanSetProvisionsWhenPackageVersionNumberOmitted [
	| unit |
	unit := self unitTestV1.
			
	unit provisions: #('A@2.0' 'B').
	
	self 
		assert: unit provisions first
		equals: 'A@2.0.0' asPackageVersionReference.
	self 
		assert: unit provisions second
		equals: 'B@1.0.0' asPackageVersionReference.
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testComparisonWithPackageAssemblyReturnsFalse [
	| unit assembly |
	unit := PBPackage named: #Test.
	assembly := PBAssembly named: 'Test'.
	self deny: unit = assembly
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testComparisonWithSamePackageUnitReturnsTrue [
	| unit |
	unit := PBPackage named: #Test.
	self assert: unit equals: unit copy
]

{ #category : #'test data' }
CGOOngoingPackageUnitTest >> unitTestV2 [
	^ unitTestV2 ifNil: [ unitTestV2 := ongoingProject newNotLoadedPackage: #Test ]

]
