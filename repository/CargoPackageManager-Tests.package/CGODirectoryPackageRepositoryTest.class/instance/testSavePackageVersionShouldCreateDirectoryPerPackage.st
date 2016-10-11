repository-specific
testSavePackageVersionShouldCreateDirectoryPerPackage
	| sandboxRepository pkgVersion |

	sandboxRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	pkgVersion := GreaseTestResource current greasecore1_1_13.
	sandboxRepository savePackageVersion: pkgVersion.
	
	self assert: (sandboxRepository rootDirectory / pkgVersion packageName asLowercase) isDirectory