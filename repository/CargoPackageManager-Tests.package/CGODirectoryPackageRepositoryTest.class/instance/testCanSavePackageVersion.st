tests
testCanSavePackageVersion
	| sandboxRepository pkgVersion |

	sandboxRepository := CGODirectoryPackageRepository basicNew 
		instVarNamed: 'rootDirectory' put: FileSystem memory root;
		initialize;
		yourself.	
	pkgVersion := GreaseTestResource current greasecore1_1_13.
	
	sandboxRepository savePackageVersion: pkgVersion.
	
	self assert: (sandboxRepository rootDirectory / pkgVersion packageName asLowercase) isDirectory.
	self assert: (sandboxRepository rootDirectory / pkgVersion packageName asLowercase / pkgVersion name asLowercase) isFile.
