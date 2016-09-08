tests
testShouldGetNotFoundWhenSymbolNotAPackageName
	self 
		should: [ #foo packageManifest ]
		raise: NotFound