tests
testShouldGetLatestPackagesAvalaibleWhenAskingBleedingEdge
	| packages |
	packages := repository bleedingEdgeOfConcretePackage: 'grease-core' for: #().
	self
		assertCollection: (packages collect: #name)
		hasSameElements: #('grease-core@1.1.13')