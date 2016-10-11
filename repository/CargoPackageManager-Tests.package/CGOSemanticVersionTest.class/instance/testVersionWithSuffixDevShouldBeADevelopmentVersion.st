tests-development versions
testVersionWithSuffixDevShouldBeADevelopmentVersion
	
	self assert: (SemanticVersion fromString: '1.0-dev') isDevelopmentVersion