tests - saving
testSavePackageVersionWhenPackageVersionIsAVirtualPackage
	| pkgVersion |

	pkgVersion := CGOVirtualPackageVersion example.
	emptyRepository savePackageVersion: pkgVersion.
	self assert: (emptyRepository virtualDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.