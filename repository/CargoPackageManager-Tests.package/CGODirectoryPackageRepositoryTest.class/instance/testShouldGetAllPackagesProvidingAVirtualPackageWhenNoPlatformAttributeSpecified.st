tests
testShouldGetAllPackagesProvidingAVirtualPackageWhenNoPlatformAttributeSpecified
	| packages |
	packages := greaseRepository packagesProvidingName: 'Grease-Slime' forPlatformAttributes: "No platform atributes" #().

	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo30-Slime@1.1.13' 'Grease-Pharo40-Slime@1.1.13')