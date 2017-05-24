execution
prepareFullExecutionInContext: aToolContext
	super prepareFullExecutionInContext: aToolContext.
	
	unitName := UIManager default 
		request: 'Package unit name' 
		initialAnswer: ''.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	project := aToolContext lastSelectedProject project.