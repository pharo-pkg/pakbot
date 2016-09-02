updating
addPartOn: aPackageName 
	self updateManifestParts: 
		(self parts copyWith: (CGOPackageDependency newFrom: aPackageName -> #()))