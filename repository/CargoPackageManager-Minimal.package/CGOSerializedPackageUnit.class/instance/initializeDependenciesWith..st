initialization
initializeDependenciesWith: aPackageUnit
	dependencies := self toArray:
			(aPackageUnit dependencies collect: 
			[ :dependency | 
			Association 
				key: dependency targetedPackage
				value: (self dependencyConstraintsMapping: dependency) ])