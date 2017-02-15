running
setUp
	super setUp.
	packageProviderStrategyBackup := CGOPackageProvider default providerStrategy.
	CGOPackageProvider default providerStrategy: CGOInImagePackageProviderStrategy new.
	packageVersions := (Seaside31PackageSpec allSubclasses 
					reject: [ :packageSpec | packageSpec = SeasidePharo30CanvasSpec ]
					thenCollect: [ :packageSpec | packageSpec new buildPackage ] ) asArray.
