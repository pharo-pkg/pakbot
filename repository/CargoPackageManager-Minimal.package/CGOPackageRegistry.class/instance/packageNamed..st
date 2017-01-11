acccessing
packageNamed: aName
	^ installedPackages 
		detect: [ :package | package packageName = aName asSymbol ]
		ifNone: [ CGOPackageNotFoundError signal: 'Cannot find ' , aName asString, ' package'  ]