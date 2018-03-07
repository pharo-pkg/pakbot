tests
testCanSerializeSimpleProject
	| project |
	
	project := CGOOngoingProject example asVcsSerializedCargoProject.
	
	self
		assert: (CGOPackageVersionWriter toStringPretty: project)
		equals: self stonStringForExampleProject