tests-serialization
testDependencyLiteralReprensentationWithNoConstraintsShouldBeDependencyAssociationWithEmptyConstraintCollection
	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #().

	self assert: dependency asLiteral equals: #A