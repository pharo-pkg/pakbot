loading
packageMetadataStonStringFor: aPackageName
	^ (CGOSourcePackageVersion 
			repository: 	self
			packageName: aPackageName) loadMetadata