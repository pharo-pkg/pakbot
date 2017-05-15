execution
prepareFullExecutionInStandardContext: aToolContext
	super prepareFullExecutionInStandardContext: aToolContext.
	project := aToolContext lastSelectedProject project.
	packageToRemove := aToolContext lastSelectedObject.
