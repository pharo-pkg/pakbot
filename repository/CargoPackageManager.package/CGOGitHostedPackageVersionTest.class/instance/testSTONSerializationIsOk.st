tests
testSTONSerializationIsOk
	| gitHostedPackageVersion |
	gitHostedPackageVersion := self cargoMinimalB9ee.
	self
		assert: (STON toString: gitHostedPackageVersion)
		equals: self stonCargoMinimalB9ee