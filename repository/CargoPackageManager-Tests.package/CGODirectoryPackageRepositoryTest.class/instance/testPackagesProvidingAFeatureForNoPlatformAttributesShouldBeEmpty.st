tests
testPackagesProvidingAFeatureForNoPlatformAttributesShouldBeEmpty

	self assert: (greaseRepository packagesProviding: 'Grease-Slime' version: '1.0' forPlatformAttributes: "No platform atributes" #()) isEmpty.