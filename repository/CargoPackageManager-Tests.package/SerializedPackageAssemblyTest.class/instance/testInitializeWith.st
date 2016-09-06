tests-initialization
testInitializeWith
	| result |
	result := self assemblyFoo asSerializedPackageVersion.
	self 
		assert: (result instVarNamed: 'parts')
		equals: {#bar->#(). #baz->#('=1.1.0')}