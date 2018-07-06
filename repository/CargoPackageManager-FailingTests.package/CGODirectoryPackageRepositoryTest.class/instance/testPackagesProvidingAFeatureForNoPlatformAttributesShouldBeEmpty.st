tests
testPackagesProvidingAFeatureForNoPlatformAttributesShouldBeEmpty

	self assert: (greaseRepository packagesProviding: 'Grease-Slime' version: '1.0' forEnvironment: "No platform atributes" #()) isEmpty.