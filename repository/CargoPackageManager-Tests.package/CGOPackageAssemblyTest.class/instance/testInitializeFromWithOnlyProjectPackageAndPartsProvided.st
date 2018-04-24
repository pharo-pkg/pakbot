tests
testInitializeFromWithOnlyProjectPackageAndPartsProvided
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
	