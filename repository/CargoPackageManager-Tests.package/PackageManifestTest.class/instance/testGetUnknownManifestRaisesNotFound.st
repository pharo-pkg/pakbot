tests
testGetUnknownManifestRaisesNotFound
	self 
		should: [ PackageManifest packageNamed: 'NonExistingPackage' ]
		raise: NotFound