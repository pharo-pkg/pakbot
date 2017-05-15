initialization
canBeExecutedInStandardContext: aToolContext
	^ aToolContext hasSelectedItems "and: [ aToolContext lastSelectedObject isRemovable ]"