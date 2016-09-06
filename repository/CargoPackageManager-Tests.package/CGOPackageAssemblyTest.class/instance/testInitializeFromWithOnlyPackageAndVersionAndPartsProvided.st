tests
testInitializeFromWithOnlyPackageAndVersionAndPartsProvided
	| dictionary assembly |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #parts -> #().
	assembly := CGOPackageVersion newFrom: dictionary.
	self 
		assert: assembly asString
		equals: 'A@1.0.0'.
	self
		assert: assembly class
		equals: CGOPackageAssembly
	