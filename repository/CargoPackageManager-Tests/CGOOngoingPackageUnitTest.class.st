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
	unit := CGOOngoingPackage named: #Test.
	self assert: unit class equals: CGOOngoingPackage
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testCanGetConvertOngoingToUnit [
	| unit |
	unit := CGOOngoingPackage example asPackageVersionOf: CGOProject example.
	
	self assert: unit project notNil.
		
	self
		assert: unit version asString
		equals: '2.1.0'.
	
	self 
		assert: unit name
		equals: #UnitTest
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
	unit := CGOOngoingPackage named: #Test.
	assembly := CGOOngoingAssembly named: 'Test'.
	self deny: unit = assembly
]

{ #category : #tests }
CGOOngoingPackageUnitTest >> testComparisonWithSamePackageUnitReturnsTrue [
	| unit |
	unit := CGOOngoingPackage named: #Test.
	self assert: unit equals: unit copy
]

{ #category : #'test data' }
CGOOngoingPackageUnitTest >> unitTestV2 [
	^ (CGOOngoingPackage named: #Test project: ongoingProject)
		description: 'A simple ongoing package unit 2.';
		yourself
]
