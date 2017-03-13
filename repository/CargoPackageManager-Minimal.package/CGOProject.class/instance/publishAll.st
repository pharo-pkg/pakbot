publishing
publishAll
	self 
		checkVersions;
		publish;
		publishPackageUnits;
		publishPackageAssemblies