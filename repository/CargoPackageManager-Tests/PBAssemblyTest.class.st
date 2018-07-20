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
	package := project createNewPackageNamed: 'TestPackage'.
	assembly := project addAssemblyNamed: 'Ass1'.
	assembly addPackage: package.
	
	self assert: (assembly packages includes: package)
]

{ #category : #tests }
PBAssemblyTest >> testCanGetProjectFromAssembly [
	| project |
	project := ongoingProject asCargoProject.
	
	self
		assert: self assemblyA1 project 
		equals: project
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
PBAssemblyTest >> testInitializeFromWithOnlyProjectPackageAndPartsProvided [
	| dictionary assembly |
	dictionary := Dictionary
		with: #package -> #A
		with: #parts -> #()
		with: #project -> CGOProject example.
	assembly := CGOPackageVersion newFrom: dictionary.
	self 
		assert: assembly packageName
		equals: #A.
	self 
		assert: assembly version asString
		equals: '2.1.0'.
	self
		assert: assembly class
		equals: CGOPackageAssembly
	
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
PBAssemblyTest >> testStonOn [
	| assembly |
	assembly := self assemblyA1.
	assembly
		instVarNamed: 'timestamp'
		put:
			(DateAndTime
				fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	self
		assert: (CGOPackageVersionWriterV1 toStringPretty: assembly)
		equals: self expectedTestStonOnResult
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
