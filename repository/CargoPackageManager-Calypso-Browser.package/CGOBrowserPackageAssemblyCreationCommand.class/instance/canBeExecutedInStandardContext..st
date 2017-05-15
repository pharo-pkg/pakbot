initialization
canBeExecutedInStandardContext: aToolContext
	^ true "aToolContext isProjectSelected
		or: [ self halt. aToolContext hasSelectedItems 
			and: [ aToolContext isPackageGroupSelected ] ]"