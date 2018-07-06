execution
execute
	unitName := UIManager default 
		request: 'New package name' 
		initialAnswer: project name, '-'.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	project createNewPackageNamed: unitName.