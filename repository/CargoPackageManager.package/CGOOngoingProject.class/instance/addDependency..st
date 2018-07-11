dependencies
addDependency: aDependency

	dependencies add: aDependency.
	aDependency project: self.
	
	CGODependenciesChanged announceOnProject: self. 