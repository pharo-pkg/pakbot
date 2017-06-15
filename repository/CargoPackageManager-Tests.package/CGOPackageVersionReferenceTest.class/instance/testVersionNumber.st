tests
testVersionNumber
	self 
		assert: pkgVersionReference versionNumber
		equals: '3.1.0' asSemanticVersion