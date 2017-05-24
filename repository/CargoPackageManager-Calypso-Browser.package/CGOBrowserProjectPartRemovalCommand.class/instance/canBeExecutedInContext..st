initialization
canBeExecutedInContext: aToolContext
	^ aToolContext hasSelectedItems "and: [ aToolContext lastSelectedObject isRemovable ]"