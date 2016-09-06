tests
testNewFromWithNoConstraint
	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #().
	self
		assert: dependency constraints size
		equals: 0.