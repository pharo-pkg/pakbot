execution
prepareFullExecutionInContext: aToolContext

	super prepareFullExecutionInContext: aToolContext.
	packageToRemove := aToolContext lastSelectedObject.
