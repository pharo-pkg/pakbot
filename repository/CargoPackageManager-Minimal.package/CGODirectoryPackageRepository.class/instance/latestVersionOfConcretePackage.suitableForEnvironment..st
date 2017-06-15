private
latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes
	^ ((self versionStringsOf: aPackageName) collect: #asPackageVersionReference)
			detectMax: [ :pkgVersion | pkgVersion versionNumber ]