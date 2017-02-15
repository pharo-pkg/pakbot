private
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	^ ((self versionStringsOf: aPackageName) collect: #asPackageVersionReference)
			detectMax: [ :pkgVersion | pkgVersion versionNumber asSemanticVersion ]