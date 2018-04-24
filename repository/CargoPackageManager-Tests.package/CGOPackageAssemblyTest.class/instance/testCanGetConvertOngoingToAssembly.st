tests
testCanGetConvertOngoingToAssembly
	| assembly |
	assembly := CGOOngoingPackageAssembly example asPackageVersionOf: self project.
	
	self assert: assembly project notNil.
		
	self
		assert: assembly version asString
		equals: '1.0.0'.
	
	self 
		assert: assembly packageName
		equals: #TestAssembly