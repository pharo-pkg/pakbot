tests
testIsPlatformPackage
	| package |
	
	package := CGOPackageProvider default packageNamed: 'Test'.
	self deny: package isPlatformPackage.
		 
	package := CGOPackageProvider default virtualPackageNamed: 'Test-Platform'.
	self assert: package isPlatformPackage