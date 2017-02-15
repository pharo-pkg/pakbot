tests
testCannotSetProvisionsWhenPackageVersionNumberOmitted
	| unit |
	unit := self unitTestV1.
			
	unit provisions: #('A@2.0' 'B').
	
	self 
		assert: unit sourcePackageVersion class
		equals: CGOGitHostedPackageVersion 