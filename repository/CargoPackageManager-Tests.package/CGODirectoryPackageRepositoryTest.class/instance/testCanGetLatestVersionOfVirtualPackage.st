tests - saving
testCanGetLatestVersionOfVirtualPackage
	| package |
	package := greaseRepository latestVersionOfPackage: 'Grease-Slime' suitableForEnvironment: #('pharo5.x').
	self
		assert: package name
		equals: 'Grease-Slime@1.0.0'