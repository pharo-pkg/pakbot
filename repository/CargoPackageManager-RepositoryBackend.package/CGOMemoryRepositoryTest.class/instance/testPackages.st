tests
testPackages
	| packages |
	
	packages := repository packageNames.
	self 
		assert: packages size
		equals: 67.
	self 
		assert: ((packages atRandom) isKindOf: CGOPackageVersion)