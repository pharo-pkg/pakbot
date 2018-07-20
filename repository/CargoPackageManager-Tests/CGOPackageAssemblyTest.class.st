Class {
	#name : #CGOPackageAssemblyTest,
	#superclass : #CGOModelTest,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #'test data' }
CGOPackageAssemblyTest >> assemblyA1 [
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
CGOPackageAssemblyTest >> expectedTestStonOnResult [
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
CGOPackageAssemblyTest >> testCanGetConvertOngoingToAssembly [
	| assembly |
	assembly := CGOOngoingAssembly example asPackageVersionOf: self project.
	
	self assert: assembly project notNil.
		
	self
		assert: assembly version asString
		equals: '1.0.0'.
	
	self 
		assert: assembly name
		equals: #TestAssembly
]

{ #category : #tests }
CGOPackageAssemblyTest >> testCanGetProjectFromAssembly [
	| project |
	project := ongoingProject asCargoProject.
	
	self
		assert: self assemblyA1 project 
		equals: project
]

{ #category : #tests }
CGOPackageAssemblyTest >> testInitializeFromEmptyDictionary [
	self 
		should: [ CGOPackageVersion newFrom: Dictionary new ]
		raise: CGOPackageVersionInitializationError
]

{ #category : #tests }
CGOPackageAssemblyTest >> testInitializeFromWithOnlyProjectPackageAndPartsProvided [
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
CGOPackageAssemblyTest >> testInitializeParts [
	| dictionary assembly |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #parts -> { #foo -> #('=1.1') .
								#bar -> #('=2.0') }
		with: #project -> CGOProject example.
	assembly := CGOPackageVersion newFrom: dictionary.
	self
		assert: assembly parts first
		equals: (CGOPackageDependency newFrom: #foo -> #('=1.1'))
]

{ #category : #tests }
CGOPackageAssemblyTest >> testStonOn [
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
