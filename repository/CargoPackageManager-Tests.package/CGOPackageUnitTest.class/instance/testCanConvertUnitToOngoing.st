tests-converting
testCanConvertUnitToOngoing
	| pkgVersion ongoing |
	pkgVersion := CGOPackageVersion fromString: 'A@1.0'.
	ongoing := pkgVersion asOngoingPackageVersion.
	self 
		assert: ongoing class
		equals: CGOOngoingPackageUnit.
		
	self 	
		assert: ongoing version
		equals: '1' asSemanticVersion.
		
	self 
		assert: ongoing packageName 
		equals: #A
