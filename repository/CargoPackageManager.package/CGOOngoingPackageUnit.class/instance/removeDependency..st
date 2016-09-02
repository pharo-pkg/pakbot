updating
removeDependency: aPackageDependency
	self updateManifestDependencies: (self dependenciesWithout: aPackageDependency)