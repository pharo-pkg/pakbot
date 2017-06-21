tests
testSTONSerializationIsOk
	| gitHostedPackageVersion |
	gitHostedPackageVersion := self cargoMinimalB9eeHttpsUrl.
	self
		assert: (STON toString: gitHostedPackageVersion)
		equals: self stonCargoMinimalB9eeHttpsUrl