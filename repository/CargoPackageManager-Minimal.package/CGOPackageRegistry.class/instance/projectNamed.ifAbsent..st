acccessing
projectNamed: aName ifAbsent: absentBlock
	^ registeredProjects 
		detect: [ :project | project name = aName asSymbol ]
		ifNone: absentBlock