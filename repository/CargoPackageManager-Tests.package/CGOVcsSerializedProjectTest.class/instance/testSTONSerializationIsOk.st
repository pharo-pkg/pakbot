tests
testSTONSerializationIsOk
	| project |
	
	project := CGOOngoingProject2 example asVcsSerializedCargoProject.
	
	self
		assert: (CGOPackageVersionWriter toStringPretty: project)
		equals: self stonStringForExampleProject