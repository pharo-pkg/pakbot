tests
testShould10devBeADevelopmentVersion
	self assert: (SemanticVersion fromString: '1.0-dev') isDevelopmentVersion