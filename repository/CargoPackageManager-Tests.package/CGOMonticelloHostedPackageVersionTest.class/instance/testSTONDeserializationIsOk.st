tests
testSTONDeserializationIsOk
	| mcHostedPackageVersion |
	mcHostedPackageVersion := STON fromString: self stonCargoMinimalCD21.
	self 
		assert: ((mcHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl