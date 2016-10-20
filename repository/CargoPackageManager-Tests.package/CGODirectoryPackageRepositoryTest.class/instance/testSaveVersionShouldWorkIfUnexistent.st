tests
testSaveVersionShouldWorkIfUnexistent
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.
	emptyRepository savePackageVersion: pkgVersion.