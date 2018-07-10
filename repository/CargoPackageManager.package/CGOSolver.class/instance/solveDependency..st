protocol
solveDependency: aDependency
	resolution addOriginDependency: aDependency.
	self addConstraintsFrom: aDependency. "will signal Dependency Conflict Error if any, even if the dependency is already resolved"

	(resolution isSolved: aDependency name)
		ifFalse: [ self solveDependenciesOf: aDependency ].
	^ resolution