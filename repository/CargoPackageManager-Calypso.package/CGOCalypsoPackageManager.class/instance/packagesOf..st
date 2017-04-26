accessing
packagesOf: aCGOProject
	^ aCGOProject packageUnits
		collect: [ :each | 
			ClyManagedPackage 
				for: (systemEnvironment packageNamed: each packageName) 
				managedBy: self ]