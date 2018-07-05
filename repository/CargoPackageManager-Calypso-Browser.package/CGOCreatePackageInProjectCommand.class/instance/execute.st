execution
execute
	unitName := UIManager default 
		request: 'Package unit name' 
		initialAnswer: ''.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	(toolContext systemEnvironment packageOrganizer includesPackageNamed: unitName)
		ifTrue: [ self error: 'Package ', unitName ,' already exists' ].
	
	self createSystemPackage.
	project newPackageUnit: unitName.