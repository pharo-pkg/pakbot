tests
testShouldGetNilWhenSymbolNotAPackageName
	self 
		assert: #foo packageManifest
		equals: nil