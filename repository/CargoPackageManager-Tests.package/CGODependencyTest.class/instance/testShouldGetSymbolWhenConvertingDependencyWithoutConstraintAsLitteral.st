tests
testShouldGetSymbolWhenConvertingDependencyWithoutConstraintAsLitteral
	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #().
	self 
		assert: dependency asLiteral 
		equals: #A