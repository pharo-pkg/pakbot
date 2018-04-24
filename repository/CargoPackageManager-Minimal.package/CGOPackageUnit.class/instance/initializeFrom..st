initialization
initializeFrom: aDictionary
	super initializeFrom: aDictionary.
	dependencies := self dependenciesFrom: aDictionary.
	provisions := self provisionsFrom: aDictionary.
	platformRequirements := aDictionary at: #platformRequirements ifAbsent: #().
	