tests-fetching
testFetchDescription
	| pkgVersionString pkgVersion stonDescription fileRef |
	
	pkgVersionString := 'Seaside-Core@3.1.0'.
	stonDescription := CGOPackageVersionWriter toStringPretty: (self packageVersions detect: [:each | each asString = pkgVersionString ]).
	fileRef := CGOPackageVersionCache packageDescriptionCache asFileReference / pkgVersionString asLowercase.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: stonDescription ].
	pkgVersion := CGOPackageVersionCache new fetchDescription: pkgVersionString.
	self
		assert: (pkgVersion isKindOf: CGOPackageVersion).
	self
		assert: pkgVersion asString
		equals: pkgVersionString.
	fileRef delete