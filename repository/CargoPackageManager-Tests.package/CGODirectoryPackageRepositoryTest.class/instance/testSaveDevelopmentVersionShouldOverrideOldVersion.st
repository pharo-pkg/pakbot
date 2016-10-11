tests
testSaveDevelopmentVersionShouldOverrideOldVersion
	| sandboxRepository pkgVersion |

	sandboxRepository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.

	sandboxRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'old').
	sandboxRepository savePackageVersion: (GreaseTestResource current greasecore1_1_13devWithDescription: 'new').
	
	self assert: (sandboxRepository fetch: 'grease-core' version: '1.1.13-dev') description equals: 'new'