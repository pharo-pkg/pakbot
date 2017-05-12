execution
prepareFullExecutionInStandardContext: aToolContext
	| packageManagers |
	super prepareFullExecutionInStandardContext: aToolContext.
	
	projectName := UIManager default 
		request: 'Project name' 
		initialAnswer: ''.
	projectName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	toolContext := aToolContext.
	
	packageManagers := aToolContext systemEnvironment projectManager packageManagers.
	packageManagers size = 1
		ifTrue: [ packageManager := packageManagers first ]
		ifFalse: [ self shouldBeImplemented ].