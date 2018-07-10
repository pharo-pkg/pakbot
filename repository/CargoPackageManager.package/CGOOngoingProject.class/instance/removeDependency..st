dependencies
removeDependency: aDependency

	dependencies remove: aDependency.
	
	CGODependenciesChanged announceOnProject: self. 