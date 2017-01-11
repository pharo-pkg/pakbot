tests
testSTONSerializationIsOk
	| mcHostedPackageVersion |
	mcHostedPackageVersion := self cargoMinimalCD21.
	self
		assert: (STON toString: mcHostedPackageVersion)
		equals: self stonCargoMinimalCD21.
	"test that the original object is not modified"
	self 
		assert: ((mcHostedPackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl