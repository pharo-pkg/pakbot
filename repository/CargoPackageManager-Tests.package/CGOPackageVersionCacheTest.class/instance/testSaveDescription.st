tests-saving
testSaveDescription
	| pkgVersionString pkgVersion fileRef |
	
	pkgVersionString := 'Seaside-Core@3.1.0'.
	pkgVersion := self packageVersions detect: [ :each | each asString = pkgVersionString ].
	CGOPackageVersionCache new saveDescription: pkgVersion.
	fileRef := CGOPackageVersionCache packageDescriptionCache asFileReference / pkgVersionString asLowercase.
	self assert: fileRef exists.
	fileRef delete