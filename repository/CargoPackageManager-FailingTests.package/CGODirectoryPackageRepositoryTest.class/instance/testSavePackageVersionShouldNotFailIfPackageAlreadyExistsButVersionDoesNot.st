tests - saving
testSavePackageVersionShouldNotFailIfPackageAlreadyExistsButVersionDoesNot
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.

	emptyRepository savePackageVersion: pkgVersion.
	emptyRepository savePackageVersion: GreaseTestResource current greasepharo30core1_1_13