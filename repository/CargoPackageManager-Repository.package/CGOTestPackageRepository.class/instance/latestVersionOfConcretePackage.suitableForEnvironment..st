versions fetching
latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes
	^ packages 
		detect: [ :package | 
				(package packageName = aPackageName)
				and: [ (package platformRequirements difference: platformAttributes) isEmpty ] ]
		ifNone: [ CGOPackageNotFoundError signal ]