private
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	^ Array with: 
		(((self versionsOf: aPackageName) collect: #asPackageVersionReference)
			detectMax: [ :pkgVersion | pkgVersion versionNumber asSemanticVersion ]) 