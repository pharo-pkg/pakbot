tests
testCanConvertAssemblyToOngoing
	| pkgVersion ongoing |
	pkgVersion := self assemblyA1.
	ongoing := pkgVersion asOngoingPackageVersion.
	self 
		assert: ongoing class
		equals: CGOOngoingPackageAssembly.
		
	self 	
		assert: ongoing version
		equals: '1' asSemanticVersion.
		
	self 
		assert: ongoing packageName 
		equals: #A
