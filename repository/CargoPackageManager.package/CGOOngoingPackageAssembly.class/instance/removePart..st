updating
removePart: aPackageDependency 
	self updateManifestParts: (self partsWithout: aPackageDependency)