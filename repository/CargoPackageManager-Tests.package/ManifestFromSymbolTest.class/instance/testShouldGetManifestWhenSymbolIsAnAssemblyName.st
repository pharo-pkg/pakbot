as yet unclassified
testShouldGetManifestWhenSymbolIsAnAssemblyName
	self 
		assert: #'Pharo-Kernel' packageManifest
		equals: PharoKernelAssembly