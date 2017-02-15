tests - saving
testShouldGetSpecificPackagesProvidingAVirtualPackageWhenPlatformAttributeSpecified
	| packages |
	packages := greaseRepository packagesProviding: 'Grease-Slime' version: '1.0' asSemanticVersion forPlatformAttributes: #('pharo5.x').
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Pharo40-Slime@1.1.13')