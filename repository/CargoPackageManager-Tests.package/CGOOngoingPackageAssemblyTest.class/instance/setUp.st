running
setUp
	super setUp.
	ongoingPkg := CGOOngoingPackageAssembly 
		on: (AssemblyManifest newNamed: 'AssemblyTest' category: 'PackageManager-Model-Serialization')