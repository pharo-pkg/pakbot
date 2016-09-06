tests
testFromString
	| dependency |
	dependency := CGODependencyConstraint fromString: '=1.0'.
	self 
		assert: dependency class
		equals: CGOFixedVersionConstraint.
	self
		assert: dependency asString
		equals: '=1.0.0'