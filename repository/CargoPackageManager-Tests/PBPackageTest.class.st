Class {
	#name : #PBPackageTest,
	#superclass : #CGOModelTest,
	#instVars : [
		'oldPackageRegistry'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBPackageTest >> testCanCreateMinimalPackage [
	| unit |
	unit := PBPackage named: #Test.
	self assert: unit class equals: PBPackage
]

{ #category : #tests }
PBPackageTest >> testCanGetProject [
	self
		assert: self unitTestV1 project 
		equals: ongoingProject
]

{ #category : #tests }
PBPackageTest >> testCanSetProvisionsWhenPackageVersionNumberOmitted [
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
PBPackageTest >> testComparisonWithPackageAssemblyReturnsFalse [
	| unit assembly |
	unit := PBPackage named: #Test.
	assembly := PBAssembly named: 'Test'.
	self deny: unit = assembly
]

{ #category : #tests }
PBPackageTest >> testComparisonWithSamePackageReturnsTrue [
	| unit |
	unit := PBPackage named: #Test.
	self assert: unit equals: unit copy
]

{ #category : #tests }
PBPackageTest >> testPackageIsInstalledWhenPackageLoaded [
	| project package |
	project := testRegistry newProjectNamed: 'Pharo-Counter-Test'.
	project repository: CGOGitRepository example.
	package := project newNotLoadedPackage: #'Counter-Core'.

	self deny: package isInstalled.
	
	package load.

	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: package isInstalled.
]

{ #category : #'test data' }
PBPackageTest >> unitTestV2 [
	^ unitTestV2 ifNil: [ unitTestV2 := ongoingProject newNotLoadedPackage: #Test ]

]
