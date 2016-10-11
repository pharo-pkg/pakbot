tests
testSaveVersionShouldFailIfVersionAlreadyExists
	| sandboxRepository pkgVersion |

	sandboxRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	pkgVersion := GreaseTestResource current greasecore1_1_13.

	sandboxRepository savePackageVersion: pkgVersion.
	self should: [sandboxRepository savePackageVersion: pkgVersion] raise: CGOPackageVersionAlreadyExistsError.