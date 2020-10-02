Class {
	#name : #PBPackageTest,
	#superclass : #PBModelTest,
	#instVars : [
		'oldPackageRegistry'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBPackageTest >> testCanAddDependencyToAProject [
	| unit |
	unit := PBPackage example.
	unit addDependency: (PBPakbotProjectDependency example).
	
	self 
		assert: unit dependencies size 
		equals: 1.
	self
		assert: unit dependencies first name
		equals: 'pharo-counter'
]

{ #category : #tests }
PBPackageTest >> testCanAddDependencyToAnotherPackage [
	| unit |
	unit := PBPackage example.
	unit addDependency: (CGOPackageDependency on: 'DependentPackage').
	
	self 
		assert: unit dependencies size 
		equals: 1.
	self
		assert: unit dependencies first name
		equals: 'DependentPackage'
]

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
PBPackageTest >> testPackageIsInstalledIfSystemPackageWithSameNameExists [
	| project package |
	project := testRegistry newProjectNamed: 'PBPackageTest'.
	package := project newNotLoadedPackage: #'Kernel'.
	
	self assert: package isInstalled
]

{ #category : #tests }
PBPackageTest >> testPackageIsInstalledWhenPackageLoaded [
	| project package |
	project := testRegistry newProjectNamed: 'Pharo-Counter-Test'.
	project repository: PBGitRepository example.
	package := project newNotLoadedPackage: #'Counter-Core'.

	self deny: package isInstalled.
	
	package load.

	self assert: (Smalltalk globals hasClassNamed: 'Counter').
	self assert: package isInstalled.
]

{ #category : #tests }
PBPackageTest >> testPackageIsNotInstalledIfNoSystemPackageWithSameName [
	| project package |
	project := testRegistry newProjectNamed: 'PBPackageTest'.
	package := project newNotLoadedPackage: #'BlaBla'.
	
	self deny: package isInstalled
]

{ #category : #'test data' }
PBPackageTest >> unitTestV2 [
	^ unitTestV2 ifNil: [ unitTestV2 := ongoingProject newNotLoadedPackage: #Test ]

]
