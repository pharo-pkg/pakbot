tests
testPackages
	| packages |
	
	packages := repository packages.
	self 
		assert: packages size
		equals: 68.
	self 
		assert: ((packages atRandom) isKindOf: CGOPackageVersion)