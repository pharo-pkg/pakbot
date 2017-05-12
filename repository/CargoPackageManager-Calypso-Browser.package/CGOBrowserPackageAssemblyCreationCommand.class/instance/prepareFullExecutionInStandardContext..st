execution
prepareFullExecutionInStandardContext: aToolContext
	super prepareFullExecutionInStandardContext: aToolContext.
	
	assemblyName := UIManager default 
		request: 'Package assembly name' 
		initialAnswer: ''.
	assemblyName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	project := aToolContext lastSelectedProject project.