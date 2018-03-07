acccessing
projectNamed: aName
	^ self 
		projectNamed: aName 
		ifAbsent: [ CGOPackageNotFoundError signal: aName asString ]