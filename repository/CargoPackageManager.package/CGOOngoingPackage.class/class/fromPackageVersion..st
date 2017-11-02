instance creation
fromPackageVersion: aCGOPackageVersion
	^ aCGOPackageVersion ongoingClass basicNew 
		initializeFromPackageVersion: aCGOPackageVersion