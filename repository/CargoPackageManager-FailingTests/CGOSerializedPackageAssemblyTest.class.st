"
A SerializedPackageAssemblyTest is a test class for testing the behavior of SerializedPackageAssembly
"
Class {
	#name : #CGOSerializedPackageAssemblyTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-FailingTests-Model-Serialization'
}

{ #category : #'test data' }
CGOSerializedPackageAssemblyTest >> assemblyFoo [
	| dictionary |
	dictionary := Dictionary
		with: #package -> #Foo
		with: #version -> '1.0'
		with: #parts -> { #bar -> #() .
								#baz -> #('=1.1') }.
	^ CGOPackageVersion newFrom: dictionary

]

{ #category : #'test data' }
CGOSerializedPackageAssemblyTest >> assemblyFooStonString [
	^ 'CGOPackageAssembly {
	#description : '''',
	#version : ''1.0.0'',
	#package : #Foo,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#parts : [
		#bar : [ ],
		#baz : [
			''=1.1.0''
		]
	]
}'
]

{ #category : #tests }
CGOSerializedPackageAssemblyTest >> testFromSton [
	| pkgAssembly |
	pkgAssembly := STON fromString: self assemblyFooStonString.
	self
		assert: pkgAssembly version
		equals: '1' asSemanticVersion.
	self
		assert: pkgAssembly packageName
		equals: 'Foo'.
	self assert: ((pkgAssembly parts collect: #class) anySatisfy: [ :class | class = PBPackageDependency ])
]

{ #category : #'tests-initialization' }
CGOSerializedPackageAssemblyTest >> testInitializeWith [
	| result |
	result := self assemblyFoo asSerializablePackageVersion.
	self 
		assert: (result instVarNamed: 'parts')
		equals: {#bar->#(). #baz->#('=1.1.0')}
]

{ #category : #tests }
CGOSerializedPackageAssemblyTest >> testStonOn [
	| serializedAssembly |
	serializedAssembly := self assemblyFoo asSerializablePackageVersion.
	serializedAssembly 
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).

	self
		assert: (PBPackageVersionWriterV1 toStringPretty: serializedAssembly)
		equals: self assemblyFooStonString
]
