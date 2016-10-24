tests
testSTONDeserializationIsOk
	| repo |
	repo := STON fromString: self stonCargoMinimalB9ee.
	self 
		assert: (repo instVarNamed: 'repositoryUrl') class 
		equals: ZnUrl