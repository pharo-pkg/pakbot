tests
testInitializeFromWithWrongVersionProvided
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> 'foo'.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: SemanticVersionFormatError