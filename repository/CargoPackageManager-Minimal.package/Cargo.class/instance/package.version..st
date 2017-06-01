configuring
package: aPackageName version: aSemanticVersionString
	packages addIfNotPresent: 
		(CGOPackageVersionReference 
			packageName: aPackageName 
			version: aSemanticVersionString)