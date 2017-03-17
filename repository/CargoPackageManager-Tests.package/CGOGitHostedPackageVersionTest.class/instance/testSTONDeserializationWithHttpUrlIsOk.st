tests
testSTONDeserializationWithHttpUrlIsOk
	| gitHostedPackageVersion repoUrl |
	gitHostedPackageVersion := STON fromString: self stonCargoMinimalB9eeHttpsUrl.
	repoUrl := ((gitHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl').
	
	self assert: (repoUrl isKindOf: String).
	self
		assert: repoUrl asString
		equals: ((self cargoMinimalB9eeHttpsUrl instVarNamed: 'repository') instVarNamed: 'repositoryUrl')