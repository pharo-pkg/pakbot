initialization
prepareFullExecutionInStandardContext: aToolContext
	super prepareFullExecutionInStandardContext: aToolContext.
	
	project := aToolContext lastSelectedProject.
	commitMessage := UIManager default 
		multiLineRequest: 'Commit message' 
		initialAnswer: '' 
		answerHeight: 200.
	commitMessage isEmptyOrNil ifTrue: [ CmdCommandAborted signal]