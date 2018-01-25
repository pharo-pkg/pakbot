tests
testCanGetMetadataFromGitRepository
	| project |
	project := CGOOngoingProject2 fromStonString: self pharoCounterMaster projectMetadataStonString.
	
	self 
		assert: project packageName
		equals: #Counter.
	self 
		assert: project packageUnits anyOne class 
		equals: CGOPackageUnit.
	
	self 
		assert: project packageUnits first packageName
		equals: #'Counter-Tests'.
		
	self 
		assert: project packageUnits first
		equals: #().
	self 
		assert: project assemblies isEmpty.
