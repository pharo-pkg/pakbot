tests-serialization
testDependencyLiteralRepresentationShouldBeDependencyAssociation
	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #('=1.0.0').

	self assert: dependency asLiteral equals: #A -> #('=1.0.0')