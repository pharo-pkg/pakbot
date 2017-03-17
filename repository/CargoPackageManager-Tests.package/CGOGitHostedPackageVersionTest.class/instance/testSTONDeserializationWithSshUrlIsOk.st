tests
testSTONDeserializationWithSshUrlIsOk
	| gitHostedPackageVersion repoUrl |
	gitHostedPackageVersion := STON fromString: self stonCargoMinimalB9ee.
	repoUrl := ((gitHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl').
	
	self assert: (repoUrl isKindOf: String).

	self
		assert: repoUrl asString
		equals: ((self cargoMinimalB9ee instVarNamed: 'repository') instVarNamed: 'repositoryUrl')