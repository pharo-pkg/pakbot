execution
prepareFullExecutionInContext: aToolContext
	super prepareFullExecutionInContext: aToolContext.
	
	projectName := UIManager default 
		request: 'Project name' 
		initialAnswer: ''.
	projectName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].