tests - saving
testCanGetBleedingEdgeOfVirtualPackage
	| package |
	package := greaseRepository bleedingEdgeOf: 'Grease-Slime' for: #('pharo5.x').
	self
		assert: package name
		equals: 'Grease-Slime@1.0.0'