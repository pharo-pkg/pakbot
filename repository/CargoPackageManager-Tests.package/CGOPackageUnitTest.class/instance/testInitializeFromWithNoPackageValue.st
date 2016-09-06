tests
testInitializeFromWithNoPackageValue
	| dictionary |
	dictionary := Dictionary with: #package -> nil.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError