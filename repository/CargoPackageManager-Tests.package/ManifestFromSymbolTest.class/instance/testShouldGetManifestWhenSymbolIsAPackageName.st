tests
testShouldGetManifestWhenSymbolIsAPackageName
	self 
		assert: #Kernel packageManifest
		equals: ManifestKernel