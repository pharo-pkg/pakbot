tests
testShouldGetAllPackagesProvidingAVirtualPackageWhenNoPlatformAttributeSpecified
	| packages |
	packages := repository packagesProviding: 'Grease-Slime' for: #().
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo30-Slime@1.1.13' 'Grease-Pharo40-Slime@1.1.13')