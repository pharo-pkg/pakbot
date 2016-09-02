updating
updatePart: aPackageDependency 
	self updateManifestParts: 
		((self partsWithout: aPackageDependency)
			copyWith: aPackageDependency)