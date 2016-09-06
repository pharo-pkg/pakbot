tests
testNewFromWithBadConstraint
	self
		should: [ CGOPackageDependency newFrom: #A -> #('foo') ]
		raise: CGODependencyConstraintFormatError
	