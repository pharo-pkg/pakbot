tests-development versions
testVersionWithoutSuffixDevShouldNotBeADevelopmentVersion
	
	self deny: (SemanticVersion fromString: '1.0-devv') isDevelopmentVersion