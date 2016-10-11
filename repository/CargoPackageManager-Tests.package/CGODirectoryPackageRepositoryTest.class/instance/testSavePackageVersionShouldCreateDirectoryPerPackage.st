repository-specific
testSavePackageVersionShouldCreateDirectoryPerPackage
	| pkgVersion |
	
	pkgVersion := GreaseTestResource current greasecore1_1_13.
	
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository rootDirectory / pkgVersion packageName asLowercase) isDirectory