tests
testSTONSerializationIsOk
	| repo |
	repo := self cargoMinimalB9ee.
	self
		assert: (STON toString: repo asSerializableSourcePackageVersion)
		equals: self stonCargoMinimalB9ee