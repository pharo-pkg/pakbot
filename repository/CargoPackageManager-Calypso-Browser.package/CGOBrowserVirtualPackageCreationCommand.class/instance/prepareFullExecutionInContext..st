execution
prepareFullExecutionInContext: aToolContext
	super prepareFullExecutionInContext: aToolContext.
	
	virtualPackageName := UIManager default 
		request: 'Virtual package name' 
		initialAnswer: ''.
	virtualPackageName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	project := aToolContext lastSelectedProject project.