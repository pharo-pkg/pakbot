tests
testCanInstantiateGitHostedPackageVersionFromAGitRepository
	| sourcePackageVersion |
	
	sourcePackageVersion := CGOSourcePackageVersion 
		repository: 	CGOGitRepository example
		packageName: 'Foo'.
	
	self 
		assert: sourcePackageVersion class 
		equals: CGOGitHostedPackageVersion 