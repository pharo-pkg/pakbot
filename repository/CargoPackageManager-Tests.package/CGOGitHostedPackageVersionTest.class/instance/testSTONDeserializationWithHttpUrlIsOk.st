tests
testSTONDeserializationWithHttpUrlIsOk
	| gitHostedPackageVersion |
	gitHostedPackageVersion := STON fromString: self stonCargoMinimalB9eeHttpsUrl.

	self 
		assertSrcPackageVersion: gitHostedPackageVersion 
		hasSameUrlAs: self cargoMinimalB9eeHttpsUrl