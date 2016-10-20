tests-creation
testCreateDependencyWithWrongVersionNumberShouldFail
	self
		should: [ CGOPackageDependency newFrom: #A -> #('=foo') ]
		raise: SemanticVersionFormatError
	