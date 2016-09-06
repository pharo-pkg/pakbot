tests
testNewFrom
	| dependency constraint |
	dependency := CGOPackageDependency newFrom: #A -> #('=1.1').
	self
		assert: dependency constraints size
		equals: 1.
	constraint := dependency constraints first.
	self
		assert: constraint class
		equals: CGOFixedVersionConstraint.
	self
		assert: constraint version
		equals: '1.1.0' asSemanticVersion