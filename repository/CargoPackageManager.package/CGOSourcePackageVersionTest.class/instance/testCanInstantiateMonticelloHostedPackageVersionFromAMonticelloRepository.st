tests
testCanInstantiateMonticelloHostedPackageVersionFromAMonticelloRepository
	| sourcePackageVersion |
	
	sourcePackageVersion := CGOSourcePackageVersion 
		repository: 	CGOMonticelloRepository example
		packageName: 'Foo'.
	
	self 
		assert: sourcePackageVersion class 
		equals: CGOMonticelloHostedPackageVersion