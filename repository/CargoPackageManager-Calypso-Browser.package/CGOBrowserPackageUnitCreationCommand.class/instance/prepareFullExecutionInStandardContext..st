execution
prepareFullExecutionInStandardContext: aToolContext
	super prepareFullExecutionInStandardContext: aToolContext.
	
	unitName := UIManager default 
		request: 'Package unit name' 
		initialAnswer: ''.
	unitName isEmptyOrNil ifTrue: [ CmdCommandAborted signal ].
	
	project := aToolContext lastSelectedProject project.