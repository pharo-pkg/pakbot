tests
testSTONDeserializationIsOk
	| repo |
	repo := STON fromString: self stonCargoMinimalCD21.
	self 
		assert: (repo instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl