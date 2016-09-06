tests
testCanGetManifestFromPackageName
	self 
		assert: (PackageManifest packageNamed: 'OneDependency')
		equals: ManifestOneDependency