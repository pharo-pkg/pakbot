tests
testCanCreateOngoingPackageUnit
	| unit |
	unit := self unitTestV1.
			
	self 
		assert: unit sourcePackageVersion class
		equals: CGOGitHostedPackageVersion 