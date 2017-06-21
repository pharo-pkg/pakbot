tests
testSTONDeserializationWithSshUrlIsOk
	| gitHostedPackageVersion |
	CGOGitHostedPackageVersionEnforcingProtocol useSshUrl.
	gitHostedPackageVersion := STON fromString: self stonCargoMinimalB9ee.
	self 
		assertSrcPackageVersion: gitHostedPackageVersion 
		hasSameUrlAs: self cargoMinimalB9ee