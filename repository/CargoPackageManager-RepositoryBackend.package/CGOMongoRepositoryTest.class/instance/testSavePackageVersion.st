tests - versions posting
testSavePackageVersion
	| pkgVersionString result |
	
	pkgVersionString := 'bar@0.2.1'.
	repository savePackageVersion: (CGOPackageVersion fromString: pkgVersionString).
	result := repository 
				fetch: #'bar'
				version: '0.2.1' asSemanticVersion.
	self 
		assert: result asString
		equals: pkgVersionString