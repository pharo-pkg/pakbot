accessing
packageNamed: aSymbol
	^ ClyManagedPackage 
			for: (systemEnvironment packageNamed: aSymbol) 
			managedBy: self