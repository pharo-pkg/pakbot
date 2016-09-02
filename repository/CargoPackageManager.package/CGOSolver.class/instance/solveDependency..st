protocol
solveDependency: aDependency
	resolution addOriginDependency: aDependency.
	self addConstraintsFrom: aDependency. "will signal Dependency Conflict Error if any, even if the dependency is already resolved"
	(self isAlreadySolved: aDependency)
		ifFalse: [ self solveDependenciesOf: aDependency ].
	^ resolution