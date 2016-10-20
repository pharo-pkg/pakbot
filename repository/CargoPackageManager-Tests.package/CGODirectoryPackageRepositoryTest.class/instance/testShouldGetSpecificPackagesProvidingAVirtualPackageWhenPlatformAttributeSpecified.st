tests
testShouldGetSpecificPackagesProvidingAVirtualPackageWhenPlatformAttributeSpecified
	| packages |
	packages := greaseRepository packagesProvidingName: 'Grease-Slime' forPlatformAttributes: #('pharo5.x').
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo40-Slime@1.1.13')