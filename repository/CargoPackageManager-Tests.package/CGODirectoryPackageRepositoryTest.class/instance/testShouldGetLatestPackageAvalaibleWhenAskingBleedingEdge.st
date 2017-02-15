tests - saving
testShouldGetLatestPackageAvalaibleWhenAskingBleedingEdge
	| package |
	package := greaseRepository bleedingEdgeOfConcretePackage: 'grease-core' for: #().
	
	self
		assert: package name
		equals: 'grease-core@1.1.13'