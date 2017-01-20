initialization
initializeFrom: aDictionary
	super initializeFrom: aDictionary.
	parts := self partsFrom: aDictionary.
	projectRepository := aDictionary at: #projectRepository ifAbsent: nil.