tests
testShouldGetSpecificPackagesProvidingAVirtualPackageWhenPlatformAttributeSpecified
	| packages |
	packages := repository packagesProviding: 'Grease-Slime' for: #('pharo5.x').
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo40-Slime@1.1.13')