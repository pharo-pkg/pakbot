repository-specific
testSavePackageVersionShouldCreateVersionFile
	| pkgVersion |

	pkgVersion := GreaseTestResource current greasecore1_1_13.
	
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository rootDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.
