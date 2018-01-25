initialization
initializeDependenciesWith: aCGOOngoingPackageUnit
	dependencies := self toArray:
			(aCGOOngoingPackageUnit dependencies collect: 
			[ :dependency | 
			Association 
				key: dependency targetedPackage
				value: (self dependencyConstraintsMapping: dependency) ])