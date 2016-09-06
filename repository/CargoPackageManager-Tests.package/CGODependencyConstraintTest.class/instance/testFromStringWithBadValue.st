tests
testFromStringWithBadValue
	self
		should: [ CGODependencyConstraint fromString: 'foo' ]
		raise: CGODependencyConstraintFormatError