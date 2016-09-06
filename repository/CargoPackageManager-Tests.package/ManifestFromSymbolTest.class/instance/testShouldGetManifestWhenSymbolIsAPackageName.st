as yet unclassified
testShouldGetManifestWhenSymbolIsAPackageName
	self 
		assert: #Kernel packageManifest
		equals: ManifestKernel