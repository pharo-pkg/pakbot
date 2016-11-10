tests
testSTONSerializationIsOk
	| repo |
	repo := self cargoMinimalCD21.
	self
		assert: (STON toString: repo asSerializableSourcePackageVersion)
		equals: self stonCargoMinimalCD21.
	"test that the original object is not modified"
	self 
		assert: (repo instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl