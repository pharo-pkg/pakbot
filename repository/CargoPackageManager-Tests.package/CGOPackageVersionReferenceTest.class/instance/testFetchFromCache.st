tests
testFetchFromCache
	| fileRef packageVersion |
	fileRef := CGOPackageVersionCache packageDescriptionCache / pkgVersionReference asString asLowercase.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: self packageVersionDescription ].
	packageVersion := pkgVersionReference fetchFromCache.
	fileRef delete.
	self assertIsExpectedPackageVersion: packageVersion