execution
execute
	unitName := UIManager default 
		request: 'New package name' 
		initialAnswer: project name, '-'.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	(toolContext systemEnvironment packageOrganizer includesPackageNamed: unitName)
		ifTrue: [ self error: 'Package ', unitName ,' already exists' ].
	
	self createSystemPackage.
	project newPackageUnit: unitName.