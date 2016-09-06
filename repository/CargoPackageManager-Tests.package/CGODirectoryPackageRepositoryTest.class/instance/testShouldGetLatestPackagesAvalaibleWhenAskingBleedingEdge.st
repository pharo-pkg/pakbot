tests
testShouldGetLatestPackagesAvalaibleWhenAskingBleedingEdge
	| packages |
	packages := repository bleedingEdgeOfConcretePackage: 'Grease-Core' for: #().
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('Grease-Core@1.1.13')