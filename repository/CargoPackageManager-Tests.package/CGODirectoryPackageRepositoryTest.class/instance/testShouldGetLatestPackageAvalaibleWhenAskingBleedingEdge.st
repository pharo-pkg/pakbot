tests - saving
testShouldGetLatestPackageAvalaibleWhenAskingBleedingEdge
	| package |
	package := greaseRepository latestVersionOfConcretePackage: 'grease-core' suitableForEnvironment: #().
	
	self
		assert: package name
		equals: 'grease-core@1.1.13'