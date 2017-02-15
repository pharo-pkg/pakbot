accessing
virtualPackageNames
	^ Seaside31TestResource current seaside31PackageVersions
		flatCollect: 
			[ :each | 
			each provisions collect: 
				[ :provision | provision asPackageVersionReference packageName ] ]
		as: Set 