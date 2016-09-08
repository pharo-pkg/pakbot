tests
testShouldGetManifestWhenSymbolIsAnAssemblyName
	self 
		assert: #'Pharo-Kernel' packageManifest
		equals: PharoKernelAssembly