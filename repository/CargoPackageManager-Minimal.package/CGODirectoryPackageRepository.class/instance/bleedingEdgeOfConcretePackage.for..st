private
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	^ Array with: 
		(((self versionStringsOf: aPackageName) collect: #asPackageVersionReference)
			detectMax: [ :pkgVersion | pkgVersion versionNumber asSemanticVersion ]) 