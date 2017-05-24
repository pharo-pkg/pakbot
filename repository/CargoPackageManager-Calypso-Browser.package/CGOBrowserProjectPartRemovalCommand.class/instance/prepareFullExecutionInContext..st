execution
prepareFullExecutionInContext: aToolContext
	super prepareFullExecutionInContext: aToolContext.
	project := aToolContext lastSelectedProject project.
	packageToRemove := aToolContext lastSelectedObject.
