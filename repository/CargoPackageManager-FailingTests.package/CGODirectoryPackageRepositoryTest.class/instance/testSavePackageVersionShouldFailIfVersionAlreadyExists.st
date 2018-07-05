tests - saving
testSavePackageVersionShouldFailIfVersionAlreadyExists
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.

	emptyRepository savePackageVersion: pkgVersion.
	self should: [emptyRepository savePackageVersion: pkgVersion] raise: CGOPackageVersionAlreadyExistsError.