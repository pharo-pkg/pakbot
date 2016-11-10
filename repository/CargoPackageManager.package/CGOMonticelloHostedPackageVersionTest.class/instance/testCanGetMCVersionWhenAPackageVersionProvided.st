tests
testCanGetMCVersionWhenAPackageVersionProvided
	| repo |
	repo := self cargoMinimalCD21.
	self assert: (repo mcVersion isKindOf: MCVersion)