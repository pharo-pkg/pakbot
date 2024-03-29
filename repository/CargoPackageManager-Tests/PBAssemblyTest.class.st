Class {
	#name : #PBAssemblyTest,
	#superclass : #PBModelTest,
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
PBAssemblyTest >> testAllPackagesListsPackagesRecursively [

	| project package1 package2 package3 package4 package5 assembly1 assembly2 assembly3 |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	package1 := project createPackageNamed: 'Package1'.
	package2 := project createPackageNamed: 'Package2'.
	package3 := project createPackageNamed: 'Package3'.
	package4 := project createPackageNamed: 'Package4'.
	package5 := project createPackageNamed: 'Package5'.
	assembly1 := project addAssemblyNamed: 'A1-P2+P3'.
	assembly1
		addPackage: package2;
		addPackage: package3.
	assembly2 := project addAssemblyNamed: 'A2-P1+A1P2P3'.
	assembly2 
		addPackage: package1;
		addPackage: assembly1.
	assembly3 := project addAssemblyNamed: 'A3-P4+A2-P1+A1P2P3'.
	assembly3
		addPackage: package4;
		addPackage: assembly2.
	
	self 
		assertCollection: assembly3 allPackages
		hasSameElements: { package1 . package2 . package3 . package4 }
]

{ #category : #tests }
PBAssemblyTest >> testAssemblyCanContainPackageExistingInItsProject [
	
	| project package assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	self assert: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testCannotCreateDuplicatedAssembly [
	
	| project assembly |
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	
	self
		should: [ assembly := project addAssemblyNamed: 'Ass1' ]
		raise: PBPackageAlreadyRegistered
]

{ #category : #tests }
PBAssemblyTest >> testCreatePackageInAssemblyConflictsWithProjectPackages [
	
	| project assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	project createPackageNamed: 'NewPackage'.
	
	assembly := project addAssemblyNamed: 'Ass1'.

	self
		should: [ assembly createPackageNamed: 'NewPackage' ]
		raise: PBSystemPackageAlreadyDefined
]

{ #category : #tests }
PBAssemblyTest >> testCreatePackageInAssemblyCreatesItInProject [
	
	| project package assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	assembly := project addAssemblyNamed: 'Ass1'.

	package := assembly createPackageNamed: 'NewPackage'.
	
	self assert: (project packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testDuplicatedAssemblyIsNotAddedInProject [
	
	| project |
	project := testRegistry newProjectNamed: 'TestProject'.
	
	project addAssemblyNamed: 'Ass1'.
	
	[ project addAssemblyNamed: 'Ass1'.
		self fail ]
			on: PBPackageAlreadyRegistered
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
	
	| project package assembly1 assembly2 |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
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
	
	| project assembly |
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	
	self assert: (project assemblies includes: assembly)
]

{ #category : #tests }
PBAssemblyTest >> testRemoveAssemblyUnlistsIt [
	
	| project assembly |
	project := testRegistry newProjectNamed: 'TestProject'.
	
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly remove.
	self deny: (project assemblies includes: assembly)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromAssemblyDoesNotTakeItOutFromProject [
	
	| project package assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	assembly removePackage: package.
	self assert: (project packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromAssemblyTakesItOutFromAssembly [
	
	| project package assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	assembly removePackage: package.
	self deny: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testRemovePackageFromProjectRemovesItFromAssembly [
	
	| project package assembly |
	testRegistry systemPackageOrganizer: RPackageOrganizer new.
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project repository: PBGitMemoryRepository new.
	package := project createPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	project removePackage: package.
	self deny: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testTwoProjectsCanHaveTheSameAssembly [
	
	| project1 project2 assembly1 assembly2 |
	project1 := testRegistry newProjectNamed: 'TestProject1'.
	project2 := testRegistry newProjectNamed: 'TestProject2'.
	
	assembly1 := project1 addAssemblyNamed: 'Ass1'.
	assembly2 := project2 addAssemblyNamed: 'Ass1'.
	
	self assert: (project1 assemblies includes: assembly1).
	self assert: (project2 assemblies includes: assembly2).
]
