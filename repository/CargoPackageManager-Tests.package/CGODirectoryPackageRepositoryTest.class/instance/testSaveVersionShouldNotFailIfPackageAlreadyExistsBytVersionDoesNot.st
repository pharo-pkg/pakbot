as yet unclassified
testSaveVersionShouldNotFailIfPackageAlreadyExistsBytVersionDoesNot
	| sandboxRepository pkgVersion |

	sandboxRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	pkgVersion := GreaseTestResource current greasecore1_1_13.

	sandboxRepository savePackageVersion: pkgVersion.
	sandboxRepository savePackageVersion: GreaseTestResource current greasepharo30core1_1_13