tests
testShould10NotBeADevelopmentVersion
	self deny: (SemanticVersion fromString: '1.0') isDevelopmentVersion