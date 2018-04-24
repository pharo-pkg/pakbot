tests
testInitializeFromWithNoProject
	" Could we create a unit without setting its project? "
	| dictionary |
	dictionary := Dictionary	with: #package -> #A.
	self 
		should: [ CGOPackageVersion newFrom: dictionary ]
		raise: CGOPackageVersionInitializationError