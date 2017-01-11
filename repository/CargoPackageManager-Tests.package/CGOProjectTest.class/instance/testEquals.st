tests
testEquals
	| projectA projectB |
	
	projectA := (CGOOngoingProject for: 'A') asCargoProject.
	projectB := (CGOOngoingProject for: 'B') asCargoProject.
	
	self assert: projectA equals: (CGOOngoingProject for: 'A') asCargoProject.
	self assert: projectA ~= projectB.
	
	projectB := (CGOOngoingProject for: 'A') asCargoProject.
	self assert: projectA equals: projectB.
	
	"We assume project version has no impact on project equality"