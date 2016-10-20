protocol
solvePackageNamed: aPackageName version: aVersionString
	
	^ self solvePackageNamed: aPackageName constraint: (CGOFixedVersionConstraint with: aVersionString)