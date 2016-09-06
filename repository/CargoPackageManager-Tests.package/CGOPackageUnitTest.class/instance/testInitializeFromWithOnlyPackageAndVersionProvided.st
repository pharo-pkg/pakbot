tests
testInitializeFromWithOnlyPackageAndVersionProvided
	| dictionary unit |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'.
	unit := CGOPackageVersion newFrom: dictionary.
	self 
		assert: unit asString
		equals: 'A@1.0.0'.
	self
		assert: unit class
		equals: CGOPackageUnit