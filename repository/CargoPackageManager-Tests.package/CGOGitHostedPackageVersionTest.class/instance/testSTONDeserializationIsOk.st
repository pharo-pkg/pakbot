tests
testSTONDeserializationIsOk
	| gitHostedPackageVersion |
	gitHostedPackageVersion := STON fromString: self stonCargoMinimalB9ee.

	self
		assert: ((gitHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl') asString
		equals: ((self cargoMinimalB9ee instVarNamed: 'repository') instVarNamed: 'repositoryUrl')