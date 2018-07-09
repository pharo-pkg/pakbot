querying
mcVersionFor: aPackageVersion
	self ensureCloned.
	^ (self iceSavedPackageVersionFor: aPackageVersion packageName) mcVersion