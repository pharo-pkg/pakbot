tests
testStonOn
	| project |
	
	project := CGOOngoingProject example asCargoProject asSerializableCargoProject.
	
	self
		assert: (CGOPackageVersionWriter toStringPretty: project)
		equals: self stonStringForExampleProject