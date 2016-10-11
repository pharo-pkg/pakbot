tests-creation
testCreateDependencyWithWrongConstraintShouldFail
	self
		should: [ CGOPackageDependency newFrom: #A -> #('foo') ]
		raise: CGODependencyConstraintFormatError
	