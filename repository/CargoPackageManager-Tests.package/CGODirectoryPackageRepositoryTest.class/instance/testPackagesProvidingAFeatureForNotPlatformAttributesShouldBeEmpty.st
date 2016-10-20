tests
testPackagesProvidingAFeatureForNotPlatformAttributesShouldBeEmpty

	self assert: (greaseRepository packagesProvidingName: 'Grease-Slime' forPlatformAttributes: "No platform atributes" #()) isEmpty.