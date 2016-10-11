tests
testSaveDevelopmentVersionShouldOverrideOldVersion

	emptyRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'old').
	emptyRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'new').
	
	self assert: (emptyRepository fetch: 'grease-core' version: '1.1.13-dev') description equals: 'new'