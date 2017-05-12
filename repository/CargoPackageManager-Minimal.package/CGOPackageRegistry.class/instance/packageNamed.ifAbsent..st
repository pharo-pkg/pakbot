acccessing
packageNamed: aName ifAbsent: absentBlock
	^ installedPackages 
		detect: [ :package | package packageName = aName asSymbol ]
		ifNone: absentBlock