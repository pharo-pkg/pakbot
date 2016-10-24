tests
testNewFromWithBadConstraintVersion
	self
		should: [ CGOPackageDependency newFrom: #A -> #('=foo') ]
		raise: SemanticVersionFormatError
	