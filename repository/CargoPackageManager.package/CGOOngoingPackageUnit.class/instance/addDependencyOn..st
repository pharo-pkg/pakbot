updating
addDependencyOn: aPackageName 
	self updateManifestDependencies: 
		(self dependencies	copyWith: (CGOPackageDependency newFrom: aPackageName -> #()))