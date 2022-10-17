Class {
	#name : #PBPackageTest,
	#superclass : #PBModelTest,
	#category : #'Pakbot-Tests-Model'
}

{ #category : #running }
PBPackageTest >> tearDown [ 
	self unloadCounterPackages.
	super tearDown.
]

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
	unit addDependency: (PBPackageDependency on: 'DependentPackage').
	
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
PBPackageTest >> testComparisonWithPackageAssemblyReturnsFalse [

	| unit assembly |
	unit := PBPackage named: #Test.
	assembly := PBAssembly named: 'Test'.
	
	self deny: unit equals: assembly
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
	project := registry newProjectNamed: 'PBPackageTest'.
	package := project newNotLoadedPackage: #'Kernel'.
	
	self assert: package isInstalled
]

{ #category : #tests }
PBPackageTest >> testPackageIsInstalledWhenPackageLoaded [
	| project package |
	project := registry newProjectNamed: 'Pharo-Counter-Test'.
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
	project := registry newProjectNamed: 'PBPackageTest'.
	package := project newNotLoadedPackage: #'BlaBla'.
	
	self deny: package isInstalled
]

{ #category : #tests }
PBPackageTest >> testProjectIsUpdatedForDependenciesWhenProjectIsSet [

	| unit |
	unit := PBPackage example.
	unit addDependency: (PBPackageDependency on: 'DependentPackage').	
	self 
		assert: unit dependencies first project
		equals: unit project.


	unit project: nil.
	self 
		assert: unit dependencies first project
		equals: unit project.
]
