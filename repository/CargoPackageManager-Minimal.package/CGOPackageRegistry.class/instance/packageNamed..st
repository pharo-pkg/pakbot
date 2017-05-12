acccessing
packageNamed: aName
	^ self 
		packageNamed: aName 
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]