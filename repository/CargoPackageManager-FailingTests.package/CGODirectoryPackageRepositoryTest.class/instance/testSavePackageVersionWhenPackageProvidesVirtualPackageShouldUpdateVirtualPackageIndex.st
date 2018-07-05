tests - saving
testSavePackageVersionWhenPackageProvidesVirtualPackageShouldUpdateVirtualPackageIndex
	| pkgVersion index |

	pkgVersion := GreaseTestResource current greasepharo40slime1_1_13.
	emptyRepository savePackageVersion: pkgVersion.
	index := (emptyRepository virtualIndexesDirectory / 'Grease-Slime' asLowercase / 'Grease-Slime@1.0.0' asLowercase).

	self assert: index isFile.