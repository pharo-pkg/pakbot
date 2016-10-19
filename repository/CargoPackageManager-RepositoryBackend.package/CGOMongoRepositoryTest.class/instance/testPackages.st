tests
testPackages
	| packages |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
	
	"packages := repository packages.
	self 
		assert: packages size
		equals: 68.
	self 
		assert: ((packages atRandom) isKindOf: CGOPackageVersion)"