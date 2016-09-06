tests
testFromStringWithBadVersion
	self
		should: [ CGODependencyConstraint fromString: '=foo' ]
		raise: SemanticVersionFormatError