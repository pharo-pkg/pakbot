execution
prepareFullExecutionInStandardContext: aToolContext
	super prepareFullExecutionInStandardContext: aToolContext.
	
	projectName := UIManager default 
		request: 'Project name' 
		initialAnswer: ''.
	projectName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].