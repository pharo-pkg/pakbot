updating
updateDependency: aPackageDependency
	self updateManifestDependencies: 
		((self dependenciesWithout: aPackageDependency)
			copyWith: aPackageDependency)