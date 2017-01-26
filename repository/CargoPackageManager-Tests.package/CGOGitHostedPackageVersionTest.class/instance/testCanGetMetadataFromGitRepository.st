tests
testCanGetMetadataFromGitRepository
	| pkgVersion |
	pkgVersion := CGOPackageVersion fromStonString: self pharoCounterTestsMaster loadMetadata.
	
	self 
		assert: pkgVersion class 
		equals: CGOPackageUnit.
	
	self 
		assert: pkgVersion packageName
		equals: #'Counter-Tests'.
		
	self 
		assert: pkgVersion provisions
		equals: #().
