tests
testCanGetMCVersionWhenAPackageVersionProvided
	| repo |
	repo := self cargoMinimalB9ee.
	self assert: (repo mcVersion isKindOf: MCVersion)