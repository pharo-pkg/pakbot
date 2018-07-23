Class {
	#name : #PBAssemblyTest,
	#superclass : #CGOModelTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #'test data' }
PBAssemblyTest >> assemblyA1 [
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A
		with:
			#parts
				->
					{(#B -> #()).
					(#C -> #('=1.1'))}
		with: #project -> self project.
	^ CGOPackageVersion newFrom: dictionary
]

{ #category : #'expected results' }
PBAssemblyTest >> expectedTestStonOnResult [
	^  '{#version:''1.0''}
CGOPublishedPackageAssembly {
	#description : '''',
	#version : ''1.0.0'',
	#package : #A,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#parts : [
		#B : [ ],
		#C : [
			''=1.1.0''
		]
	]
}'
]

{ #category : #tests }
PBAssemblyTest >> testAssemblyCanContainPackageExistingInItsProject [
	
	| testRegistry project package assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	self assert: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testCannotCreateDuplicatedAssembly [
	
	| testRegistry project assembly |
	testRegistry := CGOPackageRegistry new.
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	
	self
		should: [ assembly := project addAssemblyNamed: 'Ass1' ]
		raise: CGOPackageAlreadyRegistered
]

{ #category : #tests }
PBAssemblyTest >> testCreatePackageInAssemblyConflictsWithProjectPackages [
	
	| testRegistry project assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project createPackageNamed: 'NewPackage'.
	
	assembly := project addAssemblyNamed: 'Ass1'.

	self
		should: [ assembly createPackageNamed: 'NewPackage' ]
		raise: CGOSystemPackageAlreadyDefined
]

{ #category : #tests }
PBAssemblyTest >> testCreatePackageInAssemblyCreatesItInProject [
	
	| testRegistry project package assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	assembly := project addAssemblyNamed: 'Ass1'.

	package := assembly createPackageNamed: 'NewPackage'.
	
	self assert: (project packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testDuplicatedAssemblyIsNotAddedInProject [
	
	| testRegistry project |
	testRegistry := CGOPackageRegistry new.
	project := testRegistry newProjectNamed: 'TestProject'.
	
	project addAssemblyNamed: 'Ass1'.
	
	[ project addAssemblyNamed: 'Ass1'.
		self fail ]
			on: CGOPackageAlreadyRegistered
			do: [ "Ignore the exception" ].
			
	self assert: project assemblies size equals: 1
]

{ #category : #tests }
PBAssemblyTest >> testInitializeFromEmptyDictionary [
	self 
		should: [ CGOPackageVersion newFrom: Dictionary new ]
		raise: CGOPackageVersionInitializationError
]

{ #category : #tests }
PBAssemblyTest >> testManyAssembliesCanContainSamePackage [
	
	| testRegistry project package assembly1 assembly2 |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	package := project createPackageNamed: 'TestPackage'.
	assembly1 := project addAssemblyNamed: 'Ass1'.
	assembly2 := project addAssemblyNamed: 'Ass2'.
	
	assembly1 addPackage: package.
	assembly2 addPackage: package.
	
	self assert: (assembly1 packages includes: package).
	self assert: (assembly2 packages includes: package).
]

{ #category : #tests }
PBAssemblyTest >> testNewAssemblyIsListed [
	
	| testRegistry project assembly |
	testRegistry := CGOPackageRegistry new.
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	
	self assert: (project assemblies includes: assembly)
]

{ #category : #tests }
PBAssemblyTest >> testRemoveAssemblyUnlistsIt [
	
	| testRegistry project assembly |
	testRegistry := CGOPackageRegistry new.
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly remove.
	self deny: (project assemblies includes: assembly)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromAssemblyDoesNotTakeItOutFromProject [
	
	| testRegistry project package assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	assembly removePackage: package.
	self assert: (project packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromAssemblyTakesItOutFromAssembly [
	
	| testRegistry project package assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	assembly removePackage: package.
	self deny: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromProjectRemovesItFromAssembly [
	
	| testRegistry project package assembly |
	testRegistry := CGOPackageRegistry new.
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	project removePackage: package.
	self deny: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testTwoProjectsCanHaveTheSameAssembly [
	
	| testRegistry project1 project2 assembly1 assembly2 |
	testRegistry := CGOPackageRegistry new.
	project1 := testRegistry newProjectNamed: 'TestProject1'.
	project2 := testRegistry newProjectNamed: 'TestProject2'.
	
	assembly1 := project1 addAssemblyNamed: 'Ass1'.
	assembly2 := project2 addAssemblyNamed: 'Ass1'.
	
	self assert: (project1 assemblies includes: assembly1).
	self assert: (project2 assemblies includes: assembly2).
]
