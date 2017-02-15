accessing
virtualPackages
	^ self virtualPackageNames
		collect: [:pkgName | CGOPackageProvider default virtualPackageNamed: pkgName ]