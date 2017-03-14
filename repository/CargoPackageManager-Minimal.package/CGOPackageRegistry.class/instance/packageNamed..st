acccessing
packageNamed: aName
	^ installedPackages 
		detect: [ :package | package packageName = aName asSymbol ]
		ifNone: [ CGOPackageNotFoundError signal: aName asString ]