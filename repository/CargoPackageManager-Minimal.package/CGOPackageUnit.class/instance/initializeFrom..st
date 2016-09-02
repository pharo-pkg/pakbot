initialization
initializeFrom: aDictionary
	super initializeFrom: aDictionary.
	file := aDictionary at: #file ifAbsent: nil.
	dependencies := self dependenciesFrom: aDictionary.
	provisions := self provisionsFrom: aDictionary.
	repositories := self repositoriesFrom: aDictionary.
	platformRequirements := aDictionary at: #platformRequirements ifAbsent: #().
	