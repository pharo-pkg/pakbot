running
setUp
	super setUp.
	packageProviderStrategyBackup := CGOPackageProvider default providerStrategy.
	CGOPackageProvider default providerStrategy: CGOInImagePackageProviderStrategy new.
	packageVersions := (Seaside31PackageSpec allSubclasses 
					collect: [ :packageSpec | packageSpec new buildPackage ]) asArray.
