testing
canBeExecutedInContext: aToolContext

	^ (aToolContext isProjectSelected and: [ aToolContext selectedProjectItems size = 1 ])
		and: [ aToolContext selectedProjectItems first actualObject project hasProblems ]