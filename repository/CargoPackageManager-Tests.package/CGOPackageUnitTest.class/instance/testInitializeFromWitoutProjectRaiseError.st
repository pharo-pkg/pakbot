tests
testInitializeFromWitoutProjectRaiseError
	| dictionary |
	dictionary := Dictionary
		with: #package -> #A.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError 