accessing
projectOf: aCGOPackageVersion
	^ ClyManagedProject
		for: aCGOPackageVersion project 
		named: aCGOPackageVersion packageName 
		managedBy: self