protocol
solveDependency: aDependency
	
	"will signal Dependency Conflict Error if any, even if the dependency is already resolved"
	self addConstraintsFrom: aDependency.
	resolution addPackageResolutionFor: aDependency name.
	self solveDependenciesOf: aDependency.
	^ resolution